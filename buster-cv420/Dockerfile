#FROM balenalib/rpi-raspbian:buster
FROM lebarsfa/pi:buster
RUN apt-get update && apt-get install -y \
	sudo lsb-release wget unzip build-essential cmake libopencv-dev libgtk2.0 \
	--no-install-recommends && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
	wget http://www.ensta-bretagne.fr/lebars/Share/OpenCV-4.2.0-pi.tar.gz -nv && \
	tar xfz OpenCV-4.2.0-pi.tar.gz && \
	cp -Rf OpenCV-unknown-armv7l/* /usr/local/ && \
	rm -Rf OpenCV-unknown-armv7l OpenCV-4.2.0-pi.tar.gz
