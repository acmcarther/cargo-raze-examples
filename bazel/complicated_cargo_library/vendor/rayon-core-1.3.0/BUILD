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
    name = "rayon_core",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//complicated_cargo_library/vendor/coco-0.1.1:coco",
        "//complicated_cargo_library/vendor/lazy_static-0.2.11:lazy_static",
        "//complicated_cargo_library/vendor/libc-0.2.36:libc",
        "//complicated_cargo_library/vendor/num_cpus-1.8.0:num_cpus",
        "//complicated_cargo_library/vendor/rand-0.3.22:rand",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
    ],
)

