FROM alpine:latest

MAINTAINER Alexander Olofsson <ace@haxalot.com>

ARG VERSION=4.5.0.6-r3

RUN apk add --no-cache --update \
      coturn==$VERSION \
 && rm -rf /var/cache/apk/*

ADD coturn.sh /coturn
ADD shellexpand.sh /usr/local/bin/shell-expand

ENTRYPOINT [ "/coturn" ]
