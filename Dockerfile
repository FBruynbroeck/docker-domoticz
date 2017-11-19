FROM jsurf/rpi-raspbian:jessie

MAINTAINER FBruynbroeck

RUN [ "cross-build-start" ]

RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential && \
  apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev && \
  apt-get install -y iputils-ping && \
  apt-get install -y python3-dev python3-pip && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  pip3 install Crypto broadlink pyaes

ADD domoticz_linux_armv7l.tgz /root/domoticz
ADD plugin_broadlink.tar.gz /root/domoticz/plugins/Broadlink
RUN cp -r /usr/local/lib/python3.4/dist-packages/Crypto/ /usr/lib/python3.4/ && \
  cp -r /usr/local/lib/python3.4/dist-packages/broadlink /usr/lib/python3.4/

RUN [ "cross-build-end" ]

EXPOSE 8080

CMD ["/root/domoticz/domoticz", "-www", "8080"]
