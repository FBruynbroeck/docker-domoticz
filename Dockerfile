FROM joshuacox/mkdomoticz:arm
RUN pip3 install -U broadlink pyaes
COPY plugin_broadlink /src/domoticz/plugins/Broadlink
CMD [ "/start.sh" ]
