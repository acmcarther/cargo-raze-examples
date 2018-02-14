load("//tools/bazel-ext/proto:rust.bzl", "rust_proto_library")

rust_proto_library(
    name = "interconnect_proto",
    protos = [
        "interconnect.proto",
    ],
    with_grpc = True,
)

rust_library(
    name = "using_protobuf",
    deps = [
        ":interconnect_proto",
        "//using_protobuf/cargo:grpcio",
        "@custom_rust_protobuf//:protobuf",
    ],
)
