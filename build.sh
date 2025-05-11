#!/bin/sh
set -e

find $(dirname $0)/files -exec touch -d2025-01-01 {} +

podman build --security-opt=label=disable -t ghcr.io/eetumos/gow-umu "$@" .

VERSION=$(podman run --rm ghcr.io/eetumos/gow-umu sh -c 'cd /umu/Steam/compatibilitytools.d; basename $(readlink $PROTONPATH)')
podman tag ghcr.io/eetumos/gow-umu{,:$VERSION}
