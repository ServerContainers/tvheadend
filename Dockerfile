FROM debian:jessie

ENV LANG C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -q -y update \
 && apt-get -q -y install build-essential \
                          wget \
 && apt-get -q -y install pkg-config \
                          libssl-dev \
                          bzip2 \
                          libavahi-client-dev \
                          zlib1g-dev \
                          libavcodec-dev \
                          libavutil-dev \
                          libavformat-dev \
                          libswscale-dev \
                          libavresample-dev \
                          gettext \
                          dvb-apps \
                          cmake \
                          python \
                          git \
 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 \
 && git clone https://github.com/tvheadend/tvheadend.git /opt/tvheadend \
 && echo rm -rf /opt/tvheadend/.git \
 \
 && cd /opt/tvheadend \
 && ./configure --prefix=/ \
 && make \
 && make install \
 && cd / \
 \
 && adduser --system --ingroup video hts \
 \
 && echo 'Install Sundtek DVB-Driver' \
 && wget http://www.sundtek.de/media/sundtek_netinst.sh \
 && chmod 777 sundtek_netinst.sh \
 && ./sundtek_netinst.sh -easyvdr \
 && rm ./sundtek_netinst.sh

VOLUME ['/home/hts']

EXPOSE 9981 9982
# 9981 - HTTP server (web interface)
# 9982 - HTSP server (Streaming protocol)

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
CMD ["entrypoint.sh"]
