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
    name = "aho_corasick_dot",
    crate_root = "src/main.rs",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/memchr-2.0.1:memchr",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    
    crate_features = [
        
    ],
)
rust_library(
    name = "aho_corasick",
    crate_root = "src/lib.rs",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/memchr-2.0.1:memchr",
        
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
        
    ],
    
    crate_features = [
        
    ],
)
# Unsupported target "bench" with type "bench" omitted
# Unsupported target "dict-search" with type "example" omitted
