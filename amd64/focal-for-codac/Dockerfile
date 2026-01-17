#FROM amd64/ubuntu:focal
FROM lebarsfa/amd64:focal
RUN apt-get -q update --allow-releaseinfo-change && export DEBIAN_FRONTEND=noninteractive && export UCF_FORCE_CONFFOLD=1 && apt-get -y install \
	file zip unzip git dpkg-dev libssl-dev flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
