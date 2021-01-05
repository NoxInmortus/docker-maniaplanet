# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc + libuuid
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM frolvlad/alpine-glibc:alpine-3.12

LABEL maintainer='NoxInmortus'

RUN apk add --update --no-cache wget ca-certificates libstdc++ musl libuuid git bash build-base libffi-dev openssl-dev bzip2-dev zlib-dev readline-dev sqlite-dev xz-dev postgresql-dev libpq \
  && adduser -D -h /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PYENV_ROOT/libexec:$PATH

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
