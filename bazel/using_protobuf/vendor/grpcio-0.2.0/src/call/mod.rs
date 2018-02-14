// Copyright 2017 PingCAP, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// See the License for the specific language governing permissions and
// limitations under the License.


pub mod client;
pub mod server;

use std::{ptr, slice, usize};
use std::sync::Arc;

use cq::CompletionQueue;
use futures::{Async, Future, Poll};
use grpc_sys::{self, GrpcBatchContext, GrpcCall, GrpcCallStatus};
use libc::c_void;

use async::{self, BatchFuture, BatchMessage, BatchType, CallTag, CqFuture, SpinLock};
use codec::{DeserializeFn, Marshaller, SerializeFn};
use error::{Error, Result};

pub use grpc_sys::GrpcStatusCode as RpcStatusCode;

#[derive(Clone, Copy)]
pub enum MethodType {
    Unary,
    ClientStreaming,
    ServerStreaming,
    Duplex,
}

// TODO: add serializer and deserializer.
pub struct Method<P, Q> {
    pub ty: MethodType,
    pub name: &'static str,
    pub req_mar: Marshaller<P>,
    pub resp_mar: Marshaller<Q>,
}

impl<P, Q> Method<P, Q> {
    #[inline]
    pub fn req_ser(&self) -> SerializeFn<P> {
        self.req_mar.ser
    }

    #[inline]
    pub fn req_de(&self) -> DeserializeFn<P> {
        self.req_mar.de
    }

    #[inline]
    pub fn resp_ser(&self) -> SerializeFn<Q> {
        self.resp_mar.ser
    }

    #[inline]
    pub fn resp_de(&self) -> DeserializeFn<Q> {
        self.resp_mar.de
    }
}

/// Status return from server.
#[derive(Debug, Clone)]
pub struct RpcStatus {
    pub status: RpcStatusCode,
    pub details: Option<String>,
}

impl RpcStatus {
    pub fn new(status: RpcStatusCode, details: Option<String>) -> RpcStatus {
        RpcStatus {
            status: status,
            details: details,
        }
    }

    /// Generate an Ok status.
    pub fn ok() -> RpcStatus {
        RpcStatus::new(RpcStatusCode::Ok, None)
    }
}

/// Context for batch request.
pub struct BatchContext {
    ctx: *mut GrpcBatchContext,
}

impl BatchContext {
    pub fn new() -> BatchContext {
        BatchContext {
            ctx: unsafe { grpc_sys::grpcwrap_batch_context_create() },
        }
    }

    pub fn as_ptr(&self) -> *mut GrpcBatchContext {
        self.ctx
    }

    /// Get the status of the rpc call.
    pub fn rpc_status(&self) -> RpcStatus {
        let status =
            unsafe { grpc_sys::grpcwrap_batch_context_recv_status_on_client_status(self.ctx) };
        let details = if status == RpcStatusCode::Ok {
            None
        } else {
            unsafe {
                let mut details_len = 0;
                let details_ptr = grpc_sys::grpcwrap_batch_context_recv_status_on_client_details(
                    self.ctx,
                    &mut details_len,
                );
                let details_slice = slice::from_raw_parts(details_ptr as *const _, details_len);
                Some(String::from_utf8_lossy(details_slice).into_owned())
            }
        };

        RpcStatus {
            status: status,
            details: details,
        }
    }

    /// Fetch the response bytes of the rpc call.
    // TODO: return Read instead.
    pub fn recv_message(&self) -> Option<Vec<u8>> {
        // TODO: avoid copy
        let len = unsafe { grpc_sys::grpcwrap_batch_context_recv_message_length(self.ctx) };
        if len == usize::MAX {
            return None;
        }
        let mut buffer = Vec::with_capacity(len);
        unsafe {
            grpc_sys::grpcwrap_batch_context_recv_message_to_buffer(
                self.ctx,
                buffer.as_mut_ptr() as *mut _,
                len,
            );
            buffer.set_len(len);
        }
        Some(buffer)
    }
}

impl Drop for BatchContext {
    fn drop(&mut self) {
        unsafe { grpc_sys::grpcwrap_batch_context_destroy(self.ctx) }
    }
}

#[inline]
fn box_batch_tag(tag: CallTag) -> (*mut GrpcBatchContext, *mut c_void) {
    let tag_box = Box::new(tag);
    (
        tag_box.batch_ctx().unwrap().as_ptr(),
        Box::into_raw(tag_box) as _,
    )
}

/// A helper function that runs the batch call and checks the result.
fn check_run<F>(bt: BatchType, f: F) -> BatchFuture
where
    F: FnOnce(*mut GrpcBatchContext, *mut c_void) -> GrpcCallStatus,
{
    let (cq_f, tag) = CallTag::batch_pair(bt);
    let (batch_ptr, tag_ptr) = box_batch_tag(tag);
    let code = f(batch_ptr, tag_ptr as *mut c_void);
    if code != GrpcCallStatus::Ok {
        unsafe {
            Box::from_raw(tag_ptr);
        }
        panic!("create call fail: {:?}", code);
    }
    cq_f
}

/// A Call represents an RPC.
///
/// When created, it is in a configuration state allowing properties to be
/// set until it is invoked. After invoke, the Call can have messages
/// written to it and read from it.
pub struct Call {
    call: *mut GrpcCall,
    cq: CompletionQueue,
}

unsafe impl Send for Call {}

impl Call {
    pub unsafe fn from_raw(call: *mut grpc_sys::GrpcCall, cq: CompletionQueue) -> Call {
        assert!(!call.is_null());
        Call { call, cq }
    }

    /// Send a message asynchronously.
    pub fn start_send_message(
        &mut self,
        msg: &[u8],
        write_flags: u32,
        initial_meta: bool,
    ) -> Result<BatchFuture> {
        let _cq_ref = self.cq.borrow()?;
        let i = if initial_meta { 1 } else { 0 };
        let f = check_run(BatchType::Finish, |ctx, tag| unsafe {
            grpc_sys::grpcwrap_call_send_message(
                self.call,
                ctx,
                msg.as_ptr() as _,
                msg.len(),
                write_flags,
                i,
                tag,
            )
        });
        Ok(f)
    }

    /// Finish the rpc call from client.
    pub fn start_send_close_client(&mut self) -> Result<BatchFuture> {
        let _cq_ref = self.cq.borrow()?;
        let f = check_run(BatchType::Finish, |_, tag| unsafe {
            grpc_sys::grpcwrap_call_send_close_from_client(self.call, tag)
        });
        Ok(f)
    }

    /// Receive a message asynchronously.
    pub fn start_recv_message(&mut self) -> Result<BatchFuture> {
        let _cq_ref = self.cq.borrow()?;
        let f = check_run(BatchType::Read, |ctx, tag| unsafe {
            grpc_sys::grpcwrap_call_recv_message(self.call, ctx, tag)
        });
        Ok(f)
    }

    /// Start handling from server side.
    ///
    /// Future will finish once close is received by the server.
    pub fn start_server_side(&mut self) -> Result<BatchFuture> {
        let _cq_ref = self.cq.borrow()?;
        let f = check_run(BatchType::Finish, |ctx, tag| unsafe {
            grpc_sys::grpcwrap_call_start_serverside(self.call, ctx, tag)
        });
        Ok(f)
    }

    /// Send a status from server.
    pub fn start_send_status_from_server(
        &mut self,
        status: &RpcStatus,
        send_empty_metadata: bool,
        payload: Option<Vec<u8>>,
        write_flags: u32,
    ) -> Result<BatchFuture> {
        let _cq_ref = self.cq.borrow()?;
        let send_empty_metadata = if send_empty_metadata { 1 } else { 0 };
        let (payload_ptr, payload_len) = payload
            .as_ref()
            .map_or((ptr::null(), 0), |b| (b.as_ptr(), b.len()));
        let f = check_run(BatchType::Finish, |ctx, tag| unsafe {
            let details_ptr = status
                .details
                .as_ref()
                .map_or_else(ptr::null, |s| s.as_ptr() as _);
            let details_len = status.details.as_ref().map_or(0, String::len);
            grpc_sys::grpcwrap_call_send_status_from_server(
                self.call,
                ctx,
                status.status,
                details_ptr,
                details_len,
                ptr::null_mut(),
                send_empty_metadata,
                payload_ptr as _,
                payload_len,
                write_flags,
                tag,
            )
        });
        Ok(f)
    }

    /// Abort an rpc call before handler is called.
    pub fn abort(self, status: RpcStatus) {
        match self.cq.borrow() {
            // Queue is shutdown, ignore.
            Err(Error::QueueShutdown) => return,
            Err(e) => panic!("unexpected error when aborting call: {:?}", e),
            _ => {}
        }
        let call_ptr = self.call;
        let tag = CallTag::abort(self);
        let (batch_ptr, tag_ptr) = box_batch_tag(tag);

        let code = unsafe {
            let details_ptr = status
                .details
                .as_ref()
                .map_or_else(ptr::null, |s| s.as_ptr() as _);
            let details_len = status.details.as_ref().map_or(0, String::len);
            grpc_sys::grpcwrap_call_send_status_from_server(
                call_ptr,
                batch_ptr,
                status.status,
                details_ptr,
                details_len,
                ptr::null_mut(),
                1,
                ptr::null(),
                0,
                0,
                tag_ptr as *mut c_void,
            )
        };
        if code != GrpcCallStatus::Ok {
            unsafe {
                Box::from_raw(tag_ptr);
            }
            panic!("create call fail: {:?}", code);
        }
    }

    /// Cancel the rpc call by client.
    fn cancel(&self) {
        match self.cq.borrow() {
            // Queue is shutdown, ignore.
            Err(Error::QueueShutdown) => return,
            Err(e) => panic!("unexpected error when canceling call: {:?}", e),
            _ => {}
        }
        unsafe {
            grpc_sys::grpc_call_cancel(self.call, ptr::null_mut());
        }
    }
}

impl Drop for Call {
    fn drop(&mut self) {
        unsafe { grpc_sys::grpc_call_unref(self.call) }
    }
}

/// A share object for client streaming and duplex streaming call.
///
/// In both cases, receiver and sender can be polled in the same time,
/// hence we need to share the call in the both sides and abort the sink
/// once the call is canceled or finished early.
struct ShareCall {
    call: Call,
    close_f: CqFuture<BatchMessage>,
    finished: bool,
    status: Option<RpcStatus>,
}

impl ShareCall {
    fn new(call: Call, close_f: CqFuture<BatchMessage>) -> ShareCall {
        ShareCall {
            call: call,
            close_f: close_f,
            finished: false,
            status: None,
        }
    }

    /// Poll if the call is still alive.
    ///
    /// If the call is still running, will register a notification for its completion.
    fn poll_finish(&mut self) -> Poll<BatchMessage, Error> {
        let res = match self.close_f.poll() {
            Err(Error::RpcFailure(status)) => {
                self.status = Some(status.clone());
                Err(Error::RpcFailure(status))
            }
            Ok(Async::NotReady) => return Ok(Async::NotReady),
            Ok(Async::Ready(msg)) => {
                self.status = Some(RpcStatus::ok());
                Ok(Async::Ready(msg))
            }
            res => res,
        };

        self.finished = true;
        res
    }

    /// Check if the call is finished.
    fn check_alive(&mut self) -> Result<()> {
        if self.finished {
            // maybe can just take here.
            return Err(Error::RpcFinished(self.status.clone()));
        }

        async::check_alive(&self.close_f)
    }
}

/// A helper trait that allows executing function on the inernal `ShareCall` struct.
trait ShareCallHolder {
    fn call<R, F: FnOnce(&mut ShareCall) -> R>(&mut self, f: F) -> R;
}

impl ShareCallHolder for ShareCall {
    fn call<R, F: FnOnce(&mut ShareCall) -> R>(&mut self, f: F) -> R {
        f(self)
    }
}

impl ShareCallHolder for Arc<SpinLock<ShareCall>> {
    fn call<R, F: FnOnce(&mut ShareCall) -> R>(&mut self, f: F) -> R {
        let mut call = self.lock();
        f(&mut call)
    }
}

/// A helper struct for constructing Stream object for batch requests.
struct StreamingBase {
    close_f: Option<BatchFuture>,
    msg_f: Option<BatchFuture>,
    read_done: bool,
}

impl StreamingBase {
    fn new(close_f: Option<BatchFuture>) -> StreamingBase {
        StreamingBase {
            close_f: close_f,
            msg_f: None,
            read_done: false,
        }
    }

    fn poll<C: ShareCallHolder>(
        &mut self,
        call: &mut C,
        skip_finish_check: bool,
    ) -> Poll<Option<Vec<u8>>, Error> {
        if !skip_finish_check {
            let mut finished = false;
            if let Some(ref mut close_f) = self.close_f {
                match close_f.poll() {
                    Ok(Async::Ready(_)) => {
                        // don't return immediately, there maybe pending data.
                        finished = true;
                    }
                    Err(e) => return Err(e),
                    Ok(Async::NotReady) => {}
                }
            }
            if finished {
                self.close_f.take();
            }
        }

        let mut bytes = None;
        if !self.read_done {
            if let Some(ref mut msg_f) = self.msg_f {
                bytes = try_ready!(msg_f.poll());
                if bytes.is_none() {
                    self.read_done = true;
                }
            }
        }

        if self.read_done {
            if self.close_f.is_none() {
                return Ok(Async::Ready(None));
            }
            return Ok(Async::NotReady);
        }

        // so msg_f must be either stale or not initialised yet.
        self.msg_f.take();
        let msg_f = call.call(|c| c.call.start_recv_message())?;
        self.msg_f = Some(msg_f);
        if bytes.is_none() {
            self.poll(call, true)
        } else {
            Ok(Async::Ready(bytes))
        }
    }
}

#[derive(Default, Clone, Copy)]
pub struct WriteFlags {
    flags: u32,
}

impl WriteFlags {
    /// Hint that the write may be buffered and need not go out on the wire immediately.
    pub fn buffer_hint(mut self, need_buffered: bool) -> WriteFlags {
        client::change_flag(
            &mut self.flags,
            grpc_sys::GRPC_WRITE_BUFFER_HINT,
            need_buffered,
        );
        self
    }

    /// Force compression to be disabled.
    pub fn force_no_compress(mut self, no_compress: bool) -> WriteFlags {
        client::change_flag(
            &mut self.flags,
            grpc_sys::GRPC_WRITE_NO_COMPRESS,
            no_compress,
        );
        self
    }

    /// Get if buffer hint is enabled.
    pub fn get_buffer_hint(&self) -> bool {
        (self.flags & grpc_sys::GRPC_WRITE_BUFFER_HINT) != 0
    }

    /// Get if compression is disabled.
    pub fn get_force_no_compress(&self) -> bool {
        (self.flags & grpc_sys::GRPC_WRITE_NO_COMPRESS) != 0
    }
}

/// A helper struct for constructing Sink object for batch requests.
struct SinkBase {
    batch_f: Option<BatchFuture>,
    buf: Vec<u8>,
    send_metadata: bool,
}

impl SinkBase {
    fn new(send_metadata: bool) -> SinkBase {
        SinkBase {
            batch_f: None,
            buf: Vec::new(),
            send_metadata: send_metadata,
        }
    }

    fn start_send<T, C: ShareCallHolder>(
        &mut self,
        call: &mut C,
        t: &T,
        mut flags: WriteFlags,
        ser: SerializeFn<T>,
    ) -> Result<bool> {
        if self.batch_f.is_some() {
            // try its best not to return false.
            self.poll_complete()?;
            if self.batch_f.is_some() {
                return Ok(false);
            }
        }

        self.buf.clear();
        ser(t, &mut self.buf);
        if flags.get_buffer_hint() && self.send_metadata {
            // temporary fix: buffer hint with send meta will not send out any metadata.
            flags = flags.buffer_hint(false);
        }
        let write_f = call.call(|c| {
            c.call
                .start_send_message(&self.buf, flags.flags, self.send_metadata)
        })?;
        self.batch_f = Some(write_f);
        self.send_metadata = false;
        Ok(true)
    }

    fn poll_complete(&mut self) -> Poll<(), Error> {
        if let Some(ref mut batch_f) = self.batch_f {
            try_ready!(batch_f.poll());
        }

        self.batch_f.take();
        Ok(Async::Ready(()))
    }
}
