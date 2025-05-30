#!/bin/bash
export IMG=$(docker build -q --pull --no-cache -t 'get-version' .)

export DEBIAN_VERSION=$(docker run --rm -t get-version cat /etc/debian_version | tail -n1 | tr -d '\r')
export TVHEADEND_VERSION=$(docker run --rm -t get-version sh -c 'dpkg --list | grep tvheadend' | grep '^ii' | sed 's/^[^0-9]*//g' | cut -d ' ' -f1 | sed 's/[:~+=]/_/g' | tr -d '\r')
[ -z "$DEBIAN_VERSION" ] && exit 1

export IMGTAG=$(echo "$1d$DEBIAN_VERSION-t$TVHEADEND_VERSION")
export IMAGE_EXISTS=$(docker pull "$IMGTAG" 2>/dev/null >/dev/null; echo $?)

# return latest, if container is already available :)
if [ "$IMAGE_EXISTS" -eq 0 ]; then
  echo "$1""latest"
else
  echo "$IMGTAG"
fi
