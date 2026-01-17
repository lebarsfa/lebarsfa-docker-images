FROM balenalib/rpi:buster-build
RUN echo 'deb https://legacy.raspbian.org/raspbian/ buster main contrib non-free rpi firmware' | tee /etc/apt/sources.list && apt-get -q update --allow-releaseinfo-change && export DEBIAN_FRONTEND=noninteractive && export UCF_FORCE_CONFFOLD=1 && apt-get -y install \
	sudo lsb-release build-essential wget cmake libopencv-dev \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
