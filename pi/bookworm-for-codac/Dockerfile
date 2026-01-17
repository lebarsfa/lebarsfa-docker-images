#FROM balenalib/rpi-raspbian:bookworm
FROM lebarsfa/pi:bookworm
RUN apt-get -q update --allow-releaseinfo-change && apt-get -y install \
	sudo lsb-release file wget zip unzip git flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
