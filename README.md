Domoticz
========

Docker image for domoticz on raspberry pi with broadlink plugin.

Requirements
------------
 * Docker: http://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/

Building
--------
 * `git clone https://github.com/FBruynbroeck/docker-domoticz.git`
 * `cd docker-domoticz`
 * `make build`

Pulling
-------
 * `docker pull fbruynbroeck/rpi-domoticz`

Running
-------
    docker run --device=/dev/ttyUSB0 -v /etc/localtime:/etc/localtime:ro -v ./domoticz.db:/root/domoticz/domoticz.db:rw -v ./broadlink:/root/domoticz/broadlink:rw -p 8080:8080 --name=<container name> --restart=always -d fbruynbroeck/rpi-domoticz

Explanations

* `docker run -d fbruynbroeck/rpi-domoticz` : the basic run command
* `--device=/dev/ttyUSB0` means we expose a device we need to the container (e.g: RFXcom)
* `-v /etc/localtime:/etc/localtime:ro` : use time of the host
* `-v ./domoticz.db:/root/domoticz/domoticz.db:rw` mounts the 'backups' file to the created volume.
* `-v ./broadlink:/root/domoticz/broadlink:rw` mounts the folder to store ini files (https://www.domoticz.com/wiki/Plugins/BroadlinkRM2.html#Configuration).
* `-p 8080:8080` means that we expose the 8080 port to local 8080
   * domoticz (and our docker install) run on port 8080, but if you have anything running on your machine, this could be an issue

Docker-compose
--------------
```
domoticz:
  image: fbruynbroeck/rpi-domoticz:latest
  restart: always
  devices:
    - '/dev/ttyUSB0'
  volumes:
    - '/etc/localtime:/etc/localtime:ro'
    - './domoticz.db:/root/domoticz/domoticz.db:rw'
    - './broadlink:/root/domoticz/broadlink:rw'
  ports:
    - 8080:8080
```

Browsing
--------
 * You can now access your domoticz server on http://RASPERRY_IP:8080

Extras
------
 * Broadlink plugin (https://www.domoticz.com/wiki/Plugins/BroadlinkRM2.html)
 * iputils-ping
