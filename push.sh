#!/bin/sh
set -e

export REGISTRY_AUTH_FILE=.ghcr
podman login ghcr.io

podman images --format={{.Repository}}:{{.Tag}} ghcr.io/eetumos/gow-umu:UMU-Proton | xargs -n1 podman push --compression-format=zstd:chunked "$@"
podman images --format={{.Repository}}:{{.Tag}} ghcr.io/eetumos/gow-umu:GE-Proton  | xargs -n1 podman push --compression-format=zstd:chunked "$@"
