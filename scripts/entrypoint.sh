#!/bin/bash

cat <<EOF
################################################################################

Welcome to the servercontainers/tvheadend

################################################################################

EOF

echo '>> staring sundtek driver deamon...'
/opt/bin/mediasrv -v &
sleep 10
/opt/bin/mediaclient -e

echo '>> fixing rights...'
chmod -R a+rwX /home/hts
chown -R hts.video /home/hts
chown -R hts.video /dev/dvb

##
# CMD
##
echo ">> CMD: exec docker CMD"
echo "$@"
exec "$@"
