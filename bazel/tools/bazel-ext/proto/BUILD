package(default_visibility = ["//visibility:public"])

load("@org_pubref_rules_protobuf//protobuf:rules.bzl", "proto_language")

proto_language(
    name = "rust",
    grpc_file_extensions = ["_grpc.rs"],
    grpc_plugin = "@custom_rust_grpc_compiler//:cargo_bin_grpc_rust_plugin",
    output_to_workspace = True,
    pb_file_extensions = [".rs"],
    pb_imports = [],
    pb_plugin = "@custom_rust_protobuf//:cargo_bin_protoc_gen_rust",
    supports_grpc = True,
)
