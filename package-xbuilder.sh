#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "$0")" && pwd)"
source_xbp="${1:?Usage: package-xbuilder.sh EXISTING_PROJECT.xbp [OUTPUT.xbp]}"
output_file="${2:-$project_dir/tanktank-online-2026-10-25.xbp}"
output_file="$(cd "$(dirname "$output_file")" && pwd)/$(basename "$output_file")"
stage_dir="$(mktemp -d)"
trap 'rm -rf "$stage_dir"' EXIT

unzip -p "$source_xbp" builder-thumbnail.jpeg > "$stage_dir/builder-thumbnail.jpeg"
cp "$project_dir/builder-meta.json" "$stage_dir/"
cp -R "$project_dir/assets" "$stage_dir/"
cp "$project_dir"/*.spx "$stage_dir/"

rm -f "$output_file"
(cd "$stage_dir" && zip -q -r "$output_file" builder-meta.json builder-thumbnail.jpeg assets ./*.spx -x '*.DS_Store')
echo "$output_file"
