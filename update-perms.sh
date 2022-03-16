#!/bin/sh
echo "Executing ${0}"
# Setup user ids
UID=${UID:-1000}
GID=${GID:-1000}
groupmod -o -g "${GID}" "${USER}"
usermod -o -u "${UID}" "${USER}"

chown -Rv "${USER}":"${USER}" "${WORKDIR}"
