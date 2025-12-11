FROM quay.io/fedora/fedora:43

RUN dnf install -y glibc-langpack-en util-linux mesa-{libGL,libEGL,vulkan-drivers}.i686 \
                   mangohud.{x86_64,i686} gamescope                                     \
                   foot fzf icoextract ImageMagick jq                                   \
                   egl-utils vulkan-tools jstest-gtk
RUN <<-EOF
	dnf install -y https://github.com/Open-Wine-Components/umu-launcher/releases/latest/download/umu-launcher-1.3.0.fc43.rpm

	cat <<-CAT >/usr/bin/umu-run
		#!/usr/bin/python3
		from umu.__main__ import *
		umu_run(parse_args())
	CAT
EOF

ARG PROTONPATH
ENV XDG_DATA_HOME=/umu

RUN <<-EOF
	python <<-PYTHON
		import umu.__main__
		import umu
		from umu.umu_run import *

		pools = (ThreadPoolExecutor(), PoolManager())

		setup_umu(UMU_LOCAL / umu.__runtime_version__[1], umu.__runtime_version__, pools)
		get_umu_proton({}, pools)
	PYTHON

	rm -r /root/.cache

	if ! [ -e $XDG_DATA_HOME/Steam/compatibilitytools.d/* ]
	then
	    exit 1
	fi
	ln -s $XDG_DATA_HOME/Steam/compatibilitytools.d/{*,Proton}

	chown -R root:root $XDG_DATA_HOME
	chmod -R a=u       $XDG_DATA_HOME
EOF

ENV UMU_RUNTIME_UPDATE=0
ENV PROTONPATH=Proton
ENV PROTONFIXES_DISABLE=1

ENV HOME=/home/retro
ENV XDG_RUNTIME_DIR=/tmp

COPY files/ /
ENTRYPOINT ["entrypoint"]
