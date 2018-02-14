package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_rust//rust:rust.bzl", "rust_library")

rust_library(
    name = "grpcio_sys",
    srcs = glob(["**/*.rs"]),
    crate_features = [
        "default",
        "secure",
    ],
    crate_root = "src/lib.rs",
    crate_type = "lib",
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    deps = [
        ":grpc_wrap",
        "//using_protobuf/vendor/libc-0.2.36:libc",
        "@com_github_grpc_grpc//:grpc",
    ],
)

cc_library(
    name = "grpc_wrap",
    srcs = ["grpc_wrap.c"],
    deps = [
        "@com_github_grpc_grpc//:grpc",
    ],
)
