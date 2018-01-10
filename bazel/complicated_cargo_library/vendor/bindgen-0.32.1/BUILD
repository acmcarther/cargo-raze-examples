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
    name = "bindgen_build_script",
    srcs = glob(["**/*.rs"]),
    crate_root = "build.rs",
    data = glob([
      "*"
    ]),
    deps = [
      
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
      "default",
      "env_logger",
      "log",
      "logging",
    ],
    visibility = ["//visibility:private"],
)

genrule(
    name = "bindgen_build_script_executor",
    srcs = glob(["*", "**/*.rs"]),
    outs = ["bindgen_out_dir_outputs.tar.gz"],
    tools = [":bindgen_build_script"],
    local = 1,
    cmd = "mkdir bindgen_out_dir_outputs/;"
        + " (export CARGO_MANIFEST_DIR=\"$$PWD/complicated_cargo_library/vendor/bindgen-0.32.1\";"
        + " export TARGET='x86_64-unknown-linux-gnu';"
        + " export RUST_BACKTRACE=1;"
        + " export CARGO_FEATURE_DEFAULT=1;"
        + " export CARGO_FEATURE_ENV_LOGGER=1;"
        + " export CARGO_FEATURE_LOG=1;"
        + " export CARGO_FEATURE_LOGGING=1;"
        + " export OUT_DIR=$$PWD/bindgen_out_dir_outputs;"
        + " export BINARY_PATH=\"$$PWD/$(location :bindgen_build_script)\";"
        + " export OUT_TAR=$$PWD/$@;"
        + " cd $$(dirname $(location :Cargo.toml)) && $$BINARY_PATH && tar -czf $$OUT_TAR -C $$OUT_DIR .)"
)
rust_binary(
    # Prefix bin name to disambiguate from (probable) collision with lib name
    # N.B.: The exact form of this is subject to change.
    name = "cargo_bin_bindgen",
    crate_root = "src/main.rs",
    srcs = glob(["**/*.rs"]),
    deps = [
        # Binaries get an implicit dependency on their lib
        ":bindgen",
        "//complicated_cargo_library/vendor/cexpr-0.2.2:cexpr",
        "//complicated_cargo_library/vendor/cfg-if-0.1.2:cfg_if",
        "//complicated_cargo_library/vendor/clang-sys-0.21.1:clang_sys",
        "//complicated_cargo_library/vendor/clap-2.29.1:clap",
        "//complicated_cargo_library/vendor/env_logger-0.4.3:env_logger",
        "//complicated_cargo_library/vendor/lazy_static-1.0.0:lazy_static",
        "//complicated_cargo_library/vendor/log-0.3.9:log",
        "//complicated_cargo_library/vendor/peeking_take_while-0.1.2:peeking_take_while",
        "//complicated_cargo_library/vendor/quote-0.3.15:quote",
        "//complicated_cargo_library/vendor/regex-0.2.5:regex",
        "//complicated_cargo_library/vendor/which-1.0.3:which",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    out_dir_tar = ":bindgen_build_script_executor",
    crate_features = [
        "default",
        "env_logger",
        "log",
        "logging",
    ],
)
rust_library(
    name = "bindgen",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/cexpr-0.2.2:cexpr",
        "//complicated_cargo_library/vendor/cfg-if-0.1.2:cfg_if",
        "//complicated_cargo_library/vendor/clang-sys-0.21.1:clang_sys",
        "//complicated_cargo_library/vendor/clap-2.29.1:clap",
        "//complicated_cargo_library/vendor/env_logger-0.4.3:env_logger",
        "//complicated_cargo_library/vendor/lazy_static-1.0.0:lazy_static",
        "//complicated_cargo_library/vendor/log-0.3.9:log",
        "//complicated_cargo_library/vendor/peeking_take_while-0.1.2:peeking_take_while",
        "//complicated_cargo_library/vendor/quote-0.3.15:quote",
        "//complicated_cargo_library/vendor/regex-0.2.5:regex",
        "//complicated_cargo_library/vendor/which-1.0.3:which",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    out_dir_tar = ":bindgen_build_script_executor",
    crate_features = [
        "default",
        "env_logger",
        "log",
        "logging",
    ],
)
