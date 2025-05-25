#!/usr/bin/bash
set -e

o=()
k() {
    if [[ -n ${!1} ]]
    then
        o+=( "--env=$1=${!1}" )
    fi
}

if [[ $XDG_CURRENT_DESKTOP = GNOME ]]
then
    read GAMESCOPE_{WIDTH,HEIGHT,REFRESH} < <(gdctl show | rg -o "([0-9]+)x([0-9]+)@([0-9.]+)" -r '$1 $2 $3' | sort -nr | head -1)
fi

k GAMESCOPE_WIDTH
k GAMESCOPE_HEIGHT
k GAMESCOPE_REFRESH

k MANGOHUD_CONFIG
k MESA_VK_DEVICE_SELECT

if [[ -n $(command -v nvidia-ctk && nvidia-ctk cdi list) ]]
then
    o+=( --device=nvidia.com/gpu=all )
else
    o+=( --device=/dev/dri )
fi

maj() {
    grep -oP "[0-9]+(?= $1)" /proc/devices
}

sudo podman run                                                        \
    --rm                                                               \
    --pull=newer                                                       \
    --ipc=host                                                         \
    --security-opt=seccomp=unconfined                                  \
                                                                       \
    --volume=$XDG_RUNTIME_DIR/wayland-0:/run/user/1000/wayland-0       \
    --volume=$XDG_RUNTIME_DIR/pulse/native:/run/user/1000/pulse/native \
    --volume=/dev:/dev                                                 \
    --device-cgroup-rule="c $(maj input):* rw"                         \
    --device-cgroup-rule="c $(maj hidraw):* rw"                        \
    --group-add=input                                                  \
    --group-add=wheel                                                  \
    --env=XKB_DEFAULT_LAYOUT=$(localectl | rg -oP "X11 Layout: \K.*")  \
                                                                       \
    --volume=${u:-/opt/umu}:/opt/umu                                   \
    --volume=$HOME/Games/umu:/home/retro/Games/umu                     \
    --volume=$HOME/.cache:/home/retro/.cache                           \
                                                                       \
    "${o[@]}" ghcr.io/eetumos/gow-umu:${GOW_UMU_TAG:-latest} "$@"
