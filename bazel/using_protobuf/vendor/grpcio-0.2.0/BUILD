"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//using_protobuf:__subpackages__"])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)


# Unsupported target "alarm" with type "test" omitted
# Unsupported target "greeter_client" with type "example" omitted
# Unsupported target "greeter_server" with type "example" omitted

rust_library(
    name = "grpcio",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//using_protobuf/vendor/futures-0.1.18:futures",
        "//using_protobuf/vendor/libc-0.2.36:libc",
        "//using_protobuf/vendor/log-0.3.9:log",
        "@//using_protobuf/overrides/grpcio-sys-0.2.0:grpcio_sys",
        "@custom_rust_protobuf//:protobuf",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "default",
        "grpcio-sys",
        "protobuf",
        "protobuf-codec",
        "secure",
    ],
)

# Unsupported target "health_check" with type "test" omitted
# Unsupported target "route_guide_client" with type "example" omitted
# Unsupported target "route_guide_server" with type "example" omitted
