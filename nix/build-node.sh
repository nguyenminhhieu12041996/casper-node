#!/bin/sh

# Creates a new docker image, without importing it into the local docker repo or uploading it.

set -eu

TAG=$(git describe --always --dirty)
TARGET_REPO=clmarc

nix-build --argstr tag "${TAG}" node-container.nix

echo "Created new docker image casper-node:${TAG}."
echo
echo "Load into local docker:"
echo "docker load -i ./result"
echo
echo "Publish image"
echo "skopeo --insecure-policy copy docker-archive:./result docker://${TARGET_REPO}/casper-node:${TAG}"
