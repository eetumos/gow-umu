gow-umu (WIP)
=============
Proton for [Wolf](https://github.com/games-on-whales/wolf)

Scripts
-------
- host
    - `up`: use container on host desktop environment
    - `ud`: create desktop entries
    - `uw`: create Wolf config snippet
    - configuration: `GOW_UMU_TAG`, `GOW_UMU_DATA`, `GOW_UMU_PREFIX`, `GOW_UMU_APPLICATIONS`
- container
    - `ui`: install exe
    - `ur`: run exe

Example workflow
----------------
```
./build.sh

./bin/uh ui Freeciv Freeciv-*-setup.exe  # -> /opt/umu/Steam
./bin/uh ur Freeciv                      # -> ~/.local/share/gow-umu
./bin/ud                                 # -> /usr/local/share/applications/umu
./bin/uw                                 # -> stdout
```

Tips
----
- `up`: ensure `1000:input` can access `/dev/hidraw*`
