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


rust_library(
    name = "clap",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/ansi_term-0.10.2:ansi_term",
        "//complicated_cargo_library/vendor/atty-0.2.6:atty",
        "//complicated_cargo_library/vendor/bitflags-1.0.1:bitflags",
        "//complicated_cargo_library/vendor/strsim-0.6.0:strsim",
        "//complicated_cargo_library/vendor/textwrap-0.9.0:textwrap",
        "//complicated_cargo_library/vendor/unicode-width-0.1.4:unicode_width",
        "//complicated_cargo_library/vendor/vec_map-0.8.0:vec_map",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    
    crate_features = [
        "ansi_term",
        "atty",
        "color",
        "default",
        "strsim",
        "suggestions",
        "vec_map",
    ],
)
