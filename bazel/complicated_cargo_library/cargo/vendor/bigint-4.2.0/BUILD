"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//complicated_cargo_library/cargo:__subpackages__"])

licenses([
  "notice", # "MIT,Apache-2.0"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

rust_binary(
    name = "bigint_build_script",
    srcs = glob(["**/*.rs"]),
    crate_root = "build.rs",
    deps = [
        "//complicated_cargo_library/cargo/vendor/rustc_version-0.2.2:rustc_version",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
    ],
    data = glob(["*"]),
    visibility = ["//visibility:private"],
)

genrule(
    name = "bigint_build_script_executor",
    srcs = glob(["*", "**/*.rs"]),
    outs = ["bigint_out_dir_outputs.tar.gz"],
    tools = [":bigint_build_script"],
    local = 1,
    cmd = "mkdir bigint_out_dir_outputs/;"
        + " (export CARGO_MANIFEST_DIR=\"$$PWD/complicated_cargo_library/cargo/vendor/bigint-4.2.0\";"
        + " export RUSTC=\"$$PWD/$(location @rust_linux_x86_64//:rustc)\";"
        + " export TARGET='x86_64-unknown-linux-gnu';"
        + " export RUST_BACKTRACE=1;"
        + " export OUT_DIR=$$PWD/bigint_out_dir_outputs;"
        + " export BINARY_PATH=\"$$PWD/$(location :bigint_build_script)\";"
        + " export OUT_TAR=$$PWD/$@;"
        + " cd $$(dirname $(location :Cargo.toml)) && $$BINARY_PATH && tar -czf $$OUT_TAR -C $$OUT_DIR .)"
)

# Unsupported target "bigint" with type "bench" omitted

rust_library(
    name = "bigint",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/cargo/vendor/byteorder-1.2.1:byteorder",
        "//complicated_cargo_library/cargo/vendor/crunchy-0.1.6:crunchy",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    out_dir_tar = ":bigint_build_script_executor",
    crate_features = [
    ],
)

# Unsupported target "modular" with type "example" omitted
