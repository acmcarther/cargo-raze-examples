#! /usr/bin/env bash
set -e

# Fetches raze source into scratch
function pull_raze_source() {
  rm scratch -rf
  mkdir scratch
  git clone git@github.com:acmcarther/cargo-raze scratch/cargo-raze
}

# Builds raze using cargo, and places binary into scratch
function build_raze() {
  (cd scratch/cargo-raze && cargo build && cp target/debug/cargo-raze ../raze)
}

function plan_bazel() {
  for example_dir in $(find ./sources -maxdepth 1 -mindepth 1 -type d -printf '%f\n')
  do
    rm ../bazel/$example_dir -rf || true
    cp "./sources/$example_dir" "../bazel/$example_dir" -r
    (cd "../bazel/$example_dir" && cargo vendor -x ./vendor && ../../internal/scratch/raze raze //$example_dir --target "x86_64-unknown-linux-gnu")
  done
}

function update_readme() {
  COMMIT_HASH=$(cd ./scratch/cargo-raze && git rev-parse HEAD)
  SHORT_COMMIT_HASH=${COMMIT_HASH:0:6}
  LINE="Last run with [cargo-raze#$SHORT_COMMIT_HASH](http:\/\/github.com\/acmcarther\/cargo-raze\/commit\/$COMMIT_HASH) on `date +%Y-%m-%d`"
  sed -i "s/^Last run with.*/$LINE/" ../README.md
}

# Please run from the internal dir
if [[ ! "$PWD" =~ "cargo-raze-examples/internal" ]]; then
  echo "Please run $0 from the internal directory"
  exit 1
fi
# Please install cargo.
if [[ ! -x "$(command -v cargo)" ]]; then
  echo "Please install Cargo package manager the old fashioned way first."
  exit 1
fi
# Please install cargo-vendor (we depend on external cargo vendor for now).
if [[ -z "$(cargo --list | grep 'vendor')" ]]; then
  echo "Please install cargo-vendor (\"cargo install cargo-vendor\") first."
  exit 1
fi

pull_raze_source
build_raze
plan_bazel
update_readme
