#!/bin/sh

set -ae

cd "$(dirname "$0")/../.."

getLatestReleaseTag() {
  echo "Checking latest release version for $1..." > /dev/stderr
  gh release view --repo "$1" --json tagName --template '{{.tagName}}'
}

R2AI_VERSION=$(getLatestReleaseTag radareorg/r2ai)

echo "Updating versions in snap/snapcraft.yaml..." > /dev/stderr
yq eval -i '.version=strenv(R2AI_VERSION) | .parts.r2ai.source-tag=strenv(R2AI_VERSION)' snap/snapcraft.yaml
