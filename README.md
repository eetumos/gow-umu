gow-umu (WIP)
=============
Proton for [Wolf](https://github.com/games-on-whales/wolf)

Scripts
-------
- host
    - `gow-run`: run a gow container on the host desktop environment
    - `gow-umu-desktop`: generate desktop entries
    - `gow-umu-wolf`: generate Wolf config snippet
    - configuration: `GOW_IMAGE`, `GOW_HOME`, `GOW_UMU_DATA`, `GOW_UMU_APPLICATIONS`
- container
    - `ui`: install exe
    - `ur`: run exe

Example workflow
----------------
```
./build.sh

./bin/gow-run ui Freeciv Freeciv-*-setup.exe  # -> /opt/gow-umu/Freeciv
./bin/gow-run ur Freeciv                      # -> ~/.local/share/gow-umu
./bin/gow-umu-desktop                         # -> /usr/local/share/applications/gow-umu
./bin/gow-umu-wolf                            # -> /etc/wolf/$(whoami) + stdout
```

Tips
----
- `gow-run`: `$(whoami):input` must have access to `/dev/hidraw*`
