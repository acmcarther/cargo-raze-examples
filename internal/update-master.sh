#! /usr/bin/env bash
set -e

# Push changes to master
function push_to_master() {
  COMMIT_HASH=$(cd ./scratch/cargo-raze && git rev-parse HEAD)
  SHORT_COMMIT_HASH=${COMMIT_HASH:0:6}

  git add .
  git commit -m "Update for cargo-raze#$SHORT_COMMIT_HASH"
  git push origin master
}

# Please run from the internal dir
if [[ ! "$PWD" =~ "cargo-raze-examples/internal" ]]; then
  echo "Please run $0 from the internal directory"
  exit 1
fi

./pull-and-plan.sh
push_to_master
