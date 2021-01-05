#!/bin/ash
cd /home/container || exit

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo "$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')")
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval "${MODIFIED_STARTUP}"
