# Using protobuf

Warning! This is an advanced example!

It uses crate overrides, custom rule bindings and third party dependencies. It
also makes slightly unconventional choices (w.r.t. configured paths) in order to coexist with the
other examples.

## Overview of the moving parts

### //using_protobuf/src/BUILD

This file contains the example protobuf file, and a library that uses it. Of
note: the "cargo_base" argument here was invented to allow the macro to be
flexible w.r.t. the cargo directory, as the examples have their own dirs. 

### //using_protobuf/overrides/grpcio-sys-0.2.0/

This file contains an overridden version of the grpcio-sys crate. I can't
remember why I overrode it. Try not overriding it and see what happens!

### //tools/bazel-ext/proto:rust.bzl

This file a modified version of the standard rust protobuf plugin to generate
sources. The modification causes output files to be generated into the same file
organization as the file they were derived from, e.g. "some/path/with.proto"
becomes "some/path/with.rs", instead of just "with.rs".

The build_librs_cmd does some file wrapping and import shenanegans so that the
generated source file can be packaged and compiled as its own crate. Standard
proto generated .rs files expect to be included in some other crate -- something
we don't want to do here.

### //tools/bazel-ext/proto/BUILD

This file generates the rust proto library tool. It uses the pubref protobuf
rules, but it shouldn't take much effort to port this to Bazel's own protobuf
rules.

### //tools/bazel-ext/grpc.bzl

This file supplies the WORKSPACE with a function that can be used to define the
external GRPC dependencies. It is analogous to the "grpc_deps" function provided
by modern GRPC.

### //tools/bazel-ext/rust/codegen.bzl

This file defines a small rule to convert a pre-prepared rust source file into a
rust_library.

### //tools/bazel.rc

This file declares fake CARGO_PKG_* environment variables, as some cargo crates
will not be compilable without them.

### //third_party

This contains the external dependencies (primarily for GRPC). Of note is the two
"custom_rust_*" BUILD files: One is for the patched rust protobuf plugin, and
the other is for the patched grpc protobuf plugin.
