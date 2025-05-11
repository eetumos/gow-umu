#!/bin/sh
set -e

export REGISTRY_AUTH_FILE=.ghcr
podman login ghcr.io

podman images ghcr.io/eetumos/gow-umu:latest --format={{.Repository}}:{{.Tag}} \
    | xargs -n1 podman push
