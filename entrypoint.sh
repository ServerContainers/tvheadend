#!/bin/bash
echo '>> staring servercontainers/tvheadend container...'

echo '>> staring sundtek driver deamon...'
/opt/bin/mediasrv -v &
sleep 10
/opt/bin/mediaclient -e

echo '>> fixing rights...'
chown -R hts.video /home/hts
chown -R hts.video /dev/dvb

echo '>> starting tvheadend...'
exec /usr/local/bin/tvheadend -C -u hts -g video
