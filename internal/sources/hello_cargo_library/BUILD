load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary")

rust_binary(
    name = "hello_cargo_library",
    srcs = ["src/main.rs"],
    deps = [
        "//hello_cargo_library/vendor:fern",
        "//hello_cargo_library/vendor:log",
    ],
)
