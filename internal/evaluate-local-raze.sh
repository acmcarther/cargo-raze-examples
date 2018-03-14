#! /usr/bin/env bash
set -e

function plan_bazel() {
  for example_dir in $(find ./sources -maxdepth 1 -mindepth 1 -type d -printf '%f\n')
  do
    rm ../bazel/$example_dir -rf || true
    cp "./sources/$example_dir" "../bazel/$example_dir" -r
    if [[ $example_dir = *_remote ]]; then
      (cd "../bazel/$example_dir/cargo" && cargo raze)
    else
      (cd "../bazel/$example_dir/cargo" && cargo vendor -x ./vendor && cargo raze)
    fi

    if [[ $( cd ../bazel/$example_dir && ./sanity_check.sh) ]]; then
      echo "Sanity check failed for $example_dir"
      exit 1
    fi
  done
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
if [[ -z "$(cargo --list | grep 'vendor')" ]]; then
  echo "Please install cargo-vendor (\"cargo install cargo-vendor\") first."
  exit 1
fi
if [[ -z "$(cargo --list | grep 'raze')" ]]; then
  echo "Please install cargo-raze (\"cargo install cargo-raze\") first."
  exit 1
fi

plan_bazel
