FROM debian:bookworm

ENV PATH="/container/scripts:${PATH}"

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 \
 && apt-get -q -y update \
 && apt-get -q -y install apt-transport-https locales gnupg curl runit \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 \
 && locale-gen en_US.UTF-8 en_us \
 && dpkg-reconfigure locales \
 && dpkg-reconfigure locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8


RUN curl -1sLf 'https://dl.cloudsmith.io/public/tvheadend/tvheadend/setup.deb.sh' | bash \
 && export DEBIAN_FRONTEND=noninteractive \
 \
 && apt-get -q -y update \
 && apt-get -q -y install tvheadend \
 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# basic for WebUI and streaming
EXPOSE 9981

# for HTSP main for Kodi PVR plugin
EXPOSE 9982

COPY . /container/
HEALTHCHECK CMD ["/container/scripts/docker-healthcheck.sh"]
ENTRYPOINT ["/container/scripts/entrypoint.sh"]

CMD [ "runsvdir","-P", "/container/config/runit" ]
