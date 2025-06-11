#!/bin/sh
set -e

find files -exec touch -d2025-01-01 {} +

podman build                                  -t ghcr.io/eetumos/gow-umu:UMU-Proton "$@" .
podman build --build-arg=PROTONPATH=GE-Proton -t ghcr.io/eetumos/gow-umu:GE-Proton  "$@" .

version() {
    podman run --rm ghcr.io/eetumos/gow-umu:$1 sh -c 'cd $XDG_DATA_HOME/Steam/compatibilitytools.d; basename $(readlink $PROTONPATH)'
}

podman tag ghcr.io/eetumos/gow-umu:{UMU-Proton,$(version UMU-Proton)}
podman tag ghcr.io/eetumos/gow-umu:{GE-Proton,$(version GE-Proton)}
podman tag ghcr.io/eetumos/gow-umu:{GE-Proton,latest}
