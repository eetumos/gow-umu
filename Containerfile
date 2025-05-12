FROM quay.io/fedora/fedora:42

RUN dnf install -y glibc-langpack-en util-linux gamescope mangohud \
                   glx-utils egl-utils vulkan-tools jstest-gtk wev
RUN dnf install -y https://github.com/Open-Wine-Components/umu-launcher/releases/latest/download/umu-launcher-1.2.6.fc41.rpm

ARG PROTONPATH
ENV XDG_DATA_HOME=/umu
RUN useradd retro                                  && \
    mkdir /umu                                     && \
    chown retro:retro /umu                         && \
    runuser -u retro env GAMEID=. umu-run rundll32 && \
    rm -r /home/retro/{Games,.cache}               && \
    ln -s /umu/Steam/compatibilitytools.d/{*,Proton}
ENV UMU_RUNTIME_UPDATE=0
ENV PROTONPATH=Proton

COPY files/ur            /usr/bin/
COPY files/MangoHud.conf /etc/

ENTRYPOINT ["sh", "-c", "chown -R retro:retro /home/retro $XDG_RUNTIME_DIR && exec runuser -u retro -- \"$@\"", ""]

RUN mkdir rpmbuild                                                              && \
    cd    rpmbuild                                                              && \
    dnf install -y ripgrep rpm-build                                            && \
    dnf download --srpm gamescope                                               && \
    rpm -D "_topdir $PWD" -i gamescope-*.src.rpm                                && \
    sed -i "$(rg -nr= "^%build$" SPECS/gamescope.spec | sed 's/://') i git apply <(curl https://github.com/ValveSoftware/gamescope/commit/4da5c0a60ece2955cd60166ad0f93c93b0871723.patch)" SPECS/gamescope.spec && \
    rpmspec -P SPECS/gamescope.spec                                                \
        | rg -oP 'BuildRequires:\s*\K.*$'                                          \
        | rg -P --passthru '^[A-Za-z- ]+?\K +(?=[A-Za-z- ]+$)' -r$'\n'             \
        | xargs -d'\n' dnf install -y                                           && \
    rpmbuild -D "_topdir $PWD" -D "debug_package %nil" -bb SPECS/gamescope.spec && \
    dnf history undo last -y                                                    && \
    dnf history undo last -y                                                    && \
    dnf reinstall -y RPMS/x86_64/gamescope-[0-9]*.rpm                           && \
    cd ..                                                                       && \
    rm -r rpmbuild
