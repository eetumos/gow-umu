FROM quay.io/fedora/fedora:42

RUN dnf install -y glibc-langpack-en util-linux mangohud gamescope \
                   icoextract ImageMagick                          \
                   egl-utils vulkan-tools wev jstest-gtk
RUN dnf install -y https://github.com/Open-Wine-Components/umu-launcher/releases/latest/download/umu-launcher-1.2.6.fc41.rpm

ARG PROTONPATH
ENV XDG_DATA_HOME=/umu
RUN useradd retro                     && \
    mkdir /umu                        && \
    chown retro:retro /umu            && \
    runuser -u retro umu-run rundll32 && \
    rm -r /home/retro/{Games,.cache}  && \
    ln -s /umu/Steam/compatibilitytools.d/{*,Proton}
ENV UMU_RUNTIME_UPDATE=0
ENV PROTONPATH=Proton
ENV PROTONFIXES_DISABLE=1

COPY files/ /
ENTRYPOINT ["entrypoint"]
