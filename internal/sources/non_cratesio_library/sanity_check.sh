#! /usr/bin/env bash
set -e

bazel build //non_cratesio_library:all && bazel build //non_cratesio_library/cargo:all
