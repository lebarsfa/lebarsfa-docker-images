#FROM balenalib/rpi-raspbian:buster
FROM lebarsfa/pi:buster
RUN apt-get -q update --allow-releaseinfo-change && apt-get -y install \
	sudo lsb-release wget unzip git flex bison doxygen graphviz python3-pip python3-setuptools python3-wheel python3-breathe \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
	git clone -b actions https://github.com/lebarsfa/ibex-lib.git && \
	cd ibex-lib && \
	mkdir build && \
	cd build && \
	cmake -E env CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake -D INTERVAL_LIB=filib .. && \
	cmake --build . --target install && \
	cd ../.. && \
	rm -Rf ibex-lib
