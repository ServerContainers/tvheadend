FROM alpine

ENV PATH="/container/scripts:${PATH}"

RUN apk add --no-cache \
    runit \
  \
    tvheadend

# basic for WebUI and streaming
EXPOSE 9981

# for HTSP main for Kodi PVR plugin
EXPOSE 9982

COPY . /container/
HEALTHCHECK CMD ["/container/scripts/docker-healthcheck.sh"]
ENTRYPOINT ["/container/scripts/entrypoint.sh"]

CMD [ "runsvdir","-P", "/container/config/runit" ]
