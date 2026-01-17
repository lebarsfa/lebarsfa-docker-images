#FROM balenalib/aarch64-debian:buster-build
FROM lebarsfa/pi-64:buster
RUN apt-get -q update --allow-releaseinfo-change && export DEBIAN_FRONTEND=noninteractive && export UCF_FORCE_CONFFOLD=1 && apt-get -y install \
	file zip unzip git dpkg-dev libssl-dev flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	sudo pip3 install cmake==3.22.1 && \
	git clone --depth 1 -b Release_1_9_6 https://github.com/doxygen/doxygen.git && cd doxygen && mkdir build && cd build && cmake .. && sudo cmake --build . -j 4 --config Release --target install && cd ../.. && sudo rm -Rf Release_1_9_6 && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
