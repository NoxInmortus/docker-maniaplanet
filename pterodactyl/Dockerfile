# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc + libuuid
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM frolvlad/alpine-glibc:alpine-3.12

LABEL maintainer='NoxInmortus'

RUN apk add --update --no-cache wget ca-certificates libstdc++ musl libuuid \
  && adduser -D -h /home/container container

USER container
ENV  USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
