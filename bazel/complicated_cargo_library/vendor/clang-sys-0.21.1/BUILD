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
    name = "clang_sys_build_script",
    srcs = glob(["**/*.rs"]),
    crate_root = "build.rs",
    data = glob([
      "*"
    ]),
    deps = [
      "//complicated_cargo_library/vendor/glob-0.2.11:glob",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
      "clang_3_9",
      "gte_clang_3_6",
      "gte_clang_3_7",
      "gte_clang_3_8",
      "gte_clang_3_9",
      "libloading",
      "runtime",
    ],
    visibility = ["//visibility:private"],
)

genrule(
    name = "clang_sys_build_script_executor",
    srcs = glob(["*", "**/*.rs"]),
    outs = ["clang_sys_out_dir_outputs.tar.gz"],
    tools = [":clang_sys_build_script"],
    local = 1,
    cmd = "mkdir clang_sys_out_dir_outputs/;"
        + " (export CARGO_MANIFEST_DIR=\"$$PWD/complicated_cargo_library/vendor/clang-sys-0.21.1\";"
        + " export TARGET='x86_64-unknown-linux-gnu';"
        + " export RUST_BACKTRACE=1;"
        + " export CARGO_FEATURE_CLANG_3_9=1;"
        + " export CARGO_FEATURE_GTE_CLANG_3_6=1;"
        + " export CARGO_FEATURE_GTE_CLANG_3_7=1;"
        + " export CARGO_FEATURE_GTE_CLANG_3_8=1;"
        + " export CARGO_FEATURE_GTE_CLANG_3_9=1;"
        + " export CARGO_FEATURE_LIBLOADING=1;"
        + " export CARGO_FEATURE_RUNTIME=1;"
        + " export OUT_DIR=$$PWD/clang_sys_out_dir_outputs;"
        + " export BINARY_PATH=\"$$PWD/$(location :clang_sys_build_script)\";"
        + " export OUT_TAR=$$PWD/$@;"
        + " cd $$(dirname $(location :Cargo.toml)) && $$BINARY_PATH && tar -czf $$OUT_TAR -C $$OUT_DIR .)"
)
rust_library(
    name = "clang_sys",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/glob-0.2.11:glob",
        "//complicated_cargo_library/vendor/libc-0.2.35:libc",
        "//complicated_cargo_library/vendor/libloading-0.4.3:libloading",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    out_dir_tar = ":clang_sys_build_script_executor",
    crate_features = [
        "clang_3_9",
        "gte_clang_3_6",
        "gte_clang_3_7",
        "gte_clang_3_8",
        "gte_clang_3_9",
        "libloading",
        "runtime",
    ],
)
# Unsupported target "lib" with type "test" omitted
