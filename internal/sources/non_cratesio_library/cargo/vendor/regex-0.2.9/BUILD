"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = ["//non_cratesio_library/cargo:__subpackages__"])

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


# Unsupported target "backtrack" with type "test" omitted
# Unsupported target "backtrack-bytes" with type "test" omitted
# Unsupported target "backtrack-utf8bytes" with type "test" omitted
# Unsupported target "default" with type "test" omitted
# Unsupported target "default-bytes" with type "test" omitted
# Unsupported target "nfa" with type "test" omitted
# Unsupported target "nfa-bytes" with type "test" omitted
# Unsupported target "nfa-utf8bytes" with type "test" omitted

rust_library(
    name = "regex",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    srcs = glob(["**/*.rs"]),
    deps = [
        "//non_cratesio_library/cargo/vendor/aho-corasick-0.6.4:aho_corasick",
        "//non_cratesio_library/cargo/vendor/memchr-2.0.1:memchr",
        "//non_cratesio_library/cargo/vendor/regex-syntax-0.5.3:regex_syntax",
        "//non_cratesio_library/cargo/vendor/thread_local-0.3.5:thread_local",
        "//non_cratesio_library/cargo/vendor/utf8-ranges-1.0.0:utf8_ranges",
    ],
    rustc_flags = [
        "--cap-lints allow",
        "--target=x86_64-unknown-linux-gnu",
    ],
    crate_features = [
        "default",
    ],
)

# Unsupported target "shootout-regex-dna" with type "example" omitted
# Unsupported target "shootout-regex-dna-bytes" with type "example" omitted
# Unsupported target "shootout-regex-dna-cheat" with type "example" omitted
# Unsupported target "shootout-regex-dna-replace" with type "example" omitted
# Unsupported target "shootout-regex-dna-single" with type "example" omitted
# Unsupported target "shootout-regex-dna-single-cheat" with type "example" omitted
