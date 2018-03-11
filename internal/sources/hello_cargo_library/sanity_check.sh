#! /usr/bin/env bash
set -e

bazel build //hello_cargo_library:all
bazel build //hello_cargo_library/cargo:all
