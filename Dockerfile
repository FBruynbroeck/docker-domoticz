FROM balenalib/rpi-raspbian:stretch
MAINTAINER FBruynbroeck
RUN \
 apt-get update && \
 apt-get install -y build-essential && \
 apt-get install -y cmake libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev libssl-dev git && \
 apt-get install -y iputils-ping && \
 apt-get install -y python3 python3-dev python3-pip && \
 apt-get clean && \
 apt-get autoclean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN \
 pip3 install broadlink && \
 pip3 install pyaes
ADD domoticz_linux_armv7l.tgz /src/domoticz
COPY plugin_broadlink /src/domoticz/plugins/Broadlink
VOLUME /config
EXPOSE 8080
ENTRYPOINT ["/src/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log"]
CMD ["-www", "8080"]
