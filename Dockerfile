FROM debian:jessie

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 \
 && apt-get -q -y update \
 && apt-get -q -y install apt-transport-https locales gnupg \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 \
 && locale-gen en_US.UTF-8 en_us \
 && dpkg-reconfigure locales \
 && dpkg-reconfigure locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 \
 && echo "deb https://dl.bintray.com/tvheadend/deb jessie stable" > /etc/apt/sources.list.d/tvheadend.list \
 && export DEBIAN_FRONTEND=noninteractive \
 \
 && apt-get -q -y update \
 && apt-get -q -y install runit \
                          wget \
                          tvheadend \
 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/home/hts"]

EXPOSE 9981 9982
# 9981 - HTTP server (web interface)
# 9982 - HTSP server (Streaming protocol)

COPY scripts /usr/local/bin/

HEALTHCHECK CMD ["/usr/local/bin/docker-healthcheck.sh"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
