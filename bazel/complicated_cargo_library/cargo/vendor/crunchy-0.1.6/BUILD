"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//complicated_cargo_library/cargo:__subpackages__"])

licenses([
  "notice", # "MIT"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

rust_binary(
    name = "crunchy_build_script",
    srcs = glob(["**/*.rs"]),
    crate_root = "build.rs",
    deps = [
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
      "default",
      "limit_128",
    ],
    data = glob(["*"]),
    visibility = ["//visibility:private"],
)

genrule(
    name = "crunchy_build_script_executor",
    srcs = glob(["*", "**/*.rs"]),
    outs = ["crunchy_out_dir_outputs.tar.gz"],
    tools = [":crunchy_build_script"],
    local = 1,
    cmd = "mkdir crunchy_out_dir_outputs/;"
        + " (export CARGO_MANIFEST_DIR=\"$$PWD/complicated_cargo_library/cargo/vendor/crunchy-0.1.6\";"
        + " export RUSTC=\"$$PWD/$(location @rust_linux_x86_64//:rustc)\";"
        + " export TARGET='x86_64-unknown-linux-gnu';"
        + " export RUST_BACKTRACE=1;"
        + " export CARGO_FEATURE_DEFAULT=1;"
        + " export CARGO_FEATURE_LIMIT_128=1;"
        + " export OUT_DIR=$$PWD/crunchy_out_dir_outputs;"
        + " export BINARY_PATH=\"$$PWD/$(location :crunchy_build_script)\";"
        + " export OUT_TAR=$$PWD/$@;"
        + " cd $$(dirname $(location :Cargo.toml)) && $$BINARY_PATH && tar -czf $$OUT_TAR -C $$OUT_DIR .)"
)


rust_library(
    name = "crunchy",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    out_dir_tar = ":crunchy_build_script_executor",
    crate_features = [
        "default",
        "limit_128",
    ],
)

