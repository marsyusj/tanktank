#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "$0")" && pwd)"
workspace_dir="$(dirname "$project_dir")"

export GOPATH="$workspace_dir/.go"
export GOCACHE="$GOPATH/cache"
export XGOROOT="$GOPATH/pkg/mod/github.com/goplus/xgo@v1.7.5"
export PATH="$GOPATH/bin:$workspace_dir/bin:$PATH"

runtime_home="$project_dir/.godot-user"
mkdir -p "$runtime_home/config" "$runtime_home/data" "$runtime_home/cache"
export HOME="$runtime_home"
export XDG_CONFIG_HOME="$runtime_home/config"
export XDG_DATA_HOME="$runtime_home/data"
export XDG_CACHE_HOME="$runtime_home/cache"

cd "$project_dir"
case "${1:-run}" in
  build) exec spx build --path . ;;
  run) exec spx runnative --path . ;;
  editor) exec spx editor --path . ;;
  *)
    echo "Usage: $0 {build|run|editor}" >&2
    exit 2
    ;;
esac
