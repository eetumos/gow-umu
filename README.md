gow-umu
=======
Proton in a container, compatible with [Wolf](https://github.com/games-on-whales/wolf)

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

./bin/uh ui Steam SteamSetup.exe  # -> /opt/umu/Steam
./bin/uh ur Steam                 # -> ~/.local/share/gow-umu
./bin/ud                          # -> /usr/local/share/applications/umu
./bin/uw                          # -> stdout
```
