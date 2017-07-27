#!/bin/bash

cat <<EOF
################################################################################

Welcome to the servercontainers/tvheadend

################################################################################

EOF

echo '>> fixing rights...'
chmod -R a+rwX /home/hts
chown -R hts.video /home/hts
chown -R hts.video /dev/dvb

echo ">> RUNIT - create services"
mkdir -p /etc/sv/mediasrv /etc/sv/tvheadend
echo -e '#!/bin/sh\nexec /opt/bin/mediasrv -v' > /etc/sv/mediasrv/run
echo -e '#!/bin/sh\nsleep 10; /opt/bin/mediaclient -e; \nexec /bin/tvheadend -C -u hts -g video' > /etc/sv/tvheadend/run
chmod a+x /etc/sv/*/run /etc/sv/*/finish

echo ">> RUNIT - enable services"
ln -s /etc/sv/mediasrv /etc/service/mediasrv
ln -s /etc/sv/tvheadend /etc/service/tvheadend

exec runsvdir -P /etc/service
