gow-umu
=======
Proton for [Wolf](https://github.com/games-on-whales/wolf)

Example config
--------------
```
[[apps]]
start_audio_server = true
start_virtual_compositor = true
title = 'exe'

    [apps.runner]
    base_create_json = '{ "HostConfig": { "IpcMode": "host", "SecurityOpt": ["seccomp=unconfined"], "CapAdd": ["MKNOD"], "DeviceRequests": [ { "Driver": "cdi", "DeviceIDs": ["nvidia.com/gpu=all"] } ] }, "Cmd": ["ur", "/path/to/exe"] }'
    devices = []
    env = [ 'XKB_DEFAULT_LAYOUT=fi' ]
    image = 'ghcr.io/eetumos/gow-umu'
    mounts = [ '/home/eetu/Games/umu:/home/retro/Games/umu:Z' ]
    name = 'gow-umu'
    ports = []
    type = 'docker'

[[apps]]
start_audio_server = true
start_virtual_compositor = true
title = 'control'

    [apps.runner]
    base_create_json = '{ "HostConfig": { "IpcMode": "host", "SecurityOpt": ["seccomp=unconfined"], "CapAdd": ["MKNOD"], "DeviceRequests": [ { "Driver": "cdi", "DeviceIDs": ["nvidia.com/gpu=all"] } ] }, "Cmd": ["ur", "control"] }'
    devices = []
    env = [ 'XKB_DEFAULT_LAYOUT=fi' ]
    image = 'ghcr.io/eetumos/gow-umu'
    mounts = []
    name = 'gow-umu-control'
    ports = []
    type = 'docker'

[[apps]]
start_audio_server = true
start_virtual_compositor = true
title = 'vkcube'

    [apps.runner]
    base_create_json = '{ "HostConfig": { "IpcMode": "host", "CapAdd": ["MKNOD"], "DeviceRequests": [ { "Driver": "cdi", "DeviceIDs": ["nvidia.com/gpu=all"] } ] }, "Cmd": ["vkcube", "--wsi", "wayland"] }'
    devices = []
    env = [ 'XKB_DEFAULT_LAYOUT=fi' ]
    image = 'ghcr.io/eetumos/gow-umu'
    mounts = []
    name = 'gow-umu-vkcube'
    ports = []
    type = 'docker'

[[apps]]
start_audio_server = true
start_virtual_compositor = true
title = 'jstest-gtk'

    [apps.runner]
    base_create_json = '{ "HostConfig": { "IpcMode": "host", "CapAdd": ["MKNOD"], "DeviceRequests": [ { "Driver": "cdi", "DeviceIDs": ["nvidia.com/gpu=all"] } ] }, "Cmd": ["jstest-gtk"] }'
    devices = []
    env = [ 'XKB_DEFAULT_LAYOUT=fi' ]
    image = 'ghcr.io/eetumos/gow-umu'
    mounts = []
    name = 'gow-umu-jstest-gtk'
    ports = []
    type = 'docker'
```
