FROM balenalib/rpi-raspbian:bookworm
RUN apt-get -q update --allow-releaseinfo-change && apt-get -y install \
	sudo lsb-release build-essential wget cmake libopencv-dev \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
