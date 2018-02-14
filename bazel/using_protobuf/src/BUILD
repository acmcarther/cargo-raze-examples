load("//tools/bazel-ext/proto:rust.bzl", "rust_proto_library")

rust_proto_library(
    name = "interconnect_proto",
    cargo_base = "//using_protobuf/vendor",
    protos = [
        "interconnect.proto",
    ],
    with_grpc = True,
)

load("@io_bazel_rules_rust//rust:rust.bzl", "rust_library")

rust_library(
    name = "using_protobuf",
    srcs = ["lib.rs"],
    crate_root = "lib.rs",
    deps = [
        ":interconnect_proto",
        "//using_protobuf/vendor:grpcio",
        "@custom_rust_protobuf//:protobuf",
    ],
)
