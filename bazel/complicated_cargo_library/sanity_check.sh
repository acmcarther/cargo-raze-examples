#! /usr/bin/env bash
set -e

bazel build //complicated_cargo_library:all
bazel build //complicated_cargo_library/cargo:all
