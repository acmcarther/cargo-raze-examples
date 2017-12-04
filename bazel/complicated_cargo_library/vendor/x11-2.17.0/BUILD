"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//complicated_cargo_library:__subpackages__"])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
    "rust_bench_test",
)

rust_binary(
    name = "x11_build_script",
    srcs = glob(["**/*.rs"]),
    crate_root = "build.rs",
    data = glob([
      "*"
    ]),
    deps = [
      "//complicated_cargo_library/vendor/metadeps-1.1.2:metadeps",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    
    visibility = ["//visibility:private"],
)

genrule(
    name = "x11_build_script_executor",
    srcs = glob(["*", "**/*.rs"]),
    outs = ["x11_out_dir_outputs.tar.gz"],
    tools = [":x11_build_script"],
    local = 1,
    cmd = "mkdir x11_out_dir_outputs/;"
        + " (export CARGO_MANIFEST_DIR=\"$$PWD/complicated_cargo_library/vendor/x11-2.17.0\";"
        + " export TARGET='x86_64-unknown-linux-gnu';"
        + " export RUST_BACKTRACE=1;"
        
        + " export OUT_DIR=$$PWD/x11_out_dir_outputs;"
        + " export BINARY_PATH=\"$$PWD/$(location :x11_build_script)\";"
        + " export OUT_TAR=$$PWD/$@;"
        + " cd $$(dirname $(location :Cargo.toml)) && $$BINARY_PATH && tar -czf $$OUT_TAR -C $$OUT_DIR .)"
)
# Unsupported target "hello-world" with type "example" omitted
# Unsupported target "input" with type "example" omitted
rust_library(
    name = "x11",
    crate_root = "src/lib.rs",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/libc-0.2.34:libc",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    out_dir_tar = ":x11_build_script_executor",
    crate_features = [
        
    ],
)
# Unsupported target "xrecord" with type "example" omitted
