#FROM balenalib/aarch64-ubuntu:jammy-build
FROM lebarsfa/pi-64:jammy
RUN apt-get -q update --allow-releaseinfo-change && export DEBIAN_FRONTEND=noninteractive && export UCF_FORCE_CONFFOLD=1 && apt-get -y install \
	sudo lsb-release file wget zip unzip git dpkg-dev flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
