FROM balenalib/rpi:bookworm-build
RUN \
sudo apt update ; \
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; \
sudo sed -i -e 's/bookworm/trixie/g' /etc/apt/sources.list && \
sudo sed -i -e 's/bookworm/trixie/g' /etc/apt/sources.list.d/*.list ; \
sudo apt update ; \
sudo apt purge -y raspberrypi-ui-mods ; \
sudo apt autoremove -y ; \
sudo apt full-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --purge --auto-remove && \
sudo apt -y clean && \
sudo apt -y autoremove && \
sudo apt update ; \
sudo apt full-upgrade
