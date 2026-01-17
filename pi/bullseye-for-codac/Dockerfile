#FROM balenalib/rpi-raspbian:bullseye
FROM lebarsfa/pi:bullseye
RUN apt-get -q update --allow-releaseinfo-change && apt-get -y install \
	sudo lsb-release file wget zip unzip git flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	git clone --depth 1 -b Release_1_9_6 https://github.com/doxygen/doxygen.git && cd doxygen && mkdir build && cd build && cmake .. && sudo cmake --build . -j 4 --config Release --target install && cd ../.. && sudo rm -Rf Release_1_9_6 && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
