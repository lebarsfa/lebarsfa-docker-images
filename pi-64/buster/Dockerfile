FROM arm64v8/debian:buster
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
	printf '%s\n' \
	  'deb http://archive.debian.org/debian/ buster main contrib non-free' \
	  'deb http://archive.debian.org/debian-security buster/updates main contrib non-free' \
	  'deb http://archive.debian.org/debian/ buster-updates main contrib non-free' \
	  > /etc/apt/sources.list && \
	printf 'Acquire::Check-Valid-Until \"false\";\n' > /etc/apt/apt.conf.d/99no-check-valid-until && \
	apt-get -o Acquire::Check-Valid-Until=false update --allow-releaseinfo-change && \
	export DEBIAN_FRONTEND=noninteractive && export UCF_FORCE_CONFFOLD=1 && apt-get -y install \
	sudo lsb-release build-essential wget cmake libopencv-dev \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
