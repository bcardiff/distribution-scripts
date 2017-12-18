FROM alpine:3.7

RUN apk add --no-cache alpine-sdk coreutils cmake git

RUN adduser -G abuild -g "Alpine Package Builder" -s /bin/sh -D builder \
 && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir /packages \
 && chown builder:abuild /packages

USER builder
WORKDIR /home/builder
ENV REPODEST /packages

ENV PACKAGER "Crystal Team <crystal@manas.tech>"
ENV PACKAGER_PRIVKEY /home/builder/.abuild/crystal@manas.tech-5a38080b.rsa

ENV CFLAGS="-fPIC -pipe -O2"
