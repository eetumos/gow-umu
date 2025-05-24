FROM quay.io/fedora/fedora:42

RUN dnf install -y glibc-langpack-en util-linux mangohud \
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
