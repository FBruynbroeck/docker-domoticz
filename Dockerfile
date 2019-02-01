FROM joshuacox/mkdomoticz:arm
RUN [ "cross-build-start" ]
RUN pip3 install -U broadlink pyaes
RUN [ "cross-build-end" ]
COPY plugin_broadlink /src/domoticz/plugins/Broadlink
CMD [ "/start.sh" ]
