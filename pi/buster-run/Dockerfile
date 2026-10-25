FROM balenalib/rpi:buster-run
RUN \
cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
printf '%s\n' \
	'deb https://legacy.raspbian.org/raspbian/ buster main contrib non-free rpi firmware' \
	> /etc/apt/sources.list && \
printf 'Acquire::Check-Valid-Until \"false\";\n' > /etc/apt/apt.conf.d/99no-check-valid-until && \
apt-get -o Acquire::Check-Valid-Until=false update --allow-releaseinfo-change
