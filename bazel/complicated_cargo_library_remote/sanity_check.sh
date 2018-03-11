#! /usr/bin/env bash
set -e

bazel build //complicated_cargo_library_remote/cargo:all
