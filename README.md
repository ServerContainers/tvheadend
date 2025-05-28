# Docker Tvheadend (servercontainers/tvheadend)
_maintained by ServerContainers_

tvheadend on alpine linux

# Usage

## xmltv import

```
# inside the container
cat path/to/xmltv.xml | nc -w 5 -U /usr/share/tvheadend/.hts/tvheadend/epggrab/xmltv.sock
```

# Links

* https://tvheadend.org/projects/tvheadend/wiki/AptRepository
* https://github.com/tvheadend/tvheadend.git
* http://stackoverflow.com/questions/24225647/docker-any-way-to-give-access-to-host-usb-or-serial-device
