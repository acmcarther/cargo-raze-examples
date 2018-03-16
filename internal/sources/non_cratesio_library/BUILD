load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary")

rust_binary(
    name = "non_cratesio_library",
    srcs = ["src/main.rs"],
    deps = [
        "//non_cratesio_library/cargo:futures",
        "//non_cratesio_library/cargo:env_logger",
        "//non_cratesio_library/cargo:log"
    ],
)
