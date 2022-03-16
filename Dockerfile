#-----------------------------#
# Dockerfile ManiaPlanet      #
# by NoxInmortus              #
#-----------------------------#

FROM alpine:3.15
LABEL maintainer='NoxInmortus'

ENV DEDICATED_URL='http://files.v04.maniaplanet.com/server/ManiaplanetServer_Latest.zip' \
    USER='container' \
    UID='1000' \
    GID='1000' \
    WORKDIR='/home/container' \
    TEMPLATE_DIR='/home/container-config' \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/:/lib/" \
    GLIBC_VERSION='2.34-r0'

COPY entrypoint.sh update-perms.sh files/ /

RUN addgroup --gid ${GID} ${USER} \
    && adduser -D --uid ${UID} -h ${WORKDIR} --ingroup ${USER} ${USER} \
    && apk update \
    && apk add --no-cache unzip wget ca-certificates \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget -q -O /tmp/glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && apk add --no-cache /tmp/glibc.apk libstdc++ musl libuuid \
    && wget ${DEDICATED_URL} -nv -O /tmp/dedicated.zip \
    && mkdir -pv ${WORKDIR}/GameData ${TEMPLATE_DIR} \
    && unzip -quo /tmp/dedicated.zip -d ${WORKDIR} \
    && mv -v /matchsettings.xml ${TEMPLATE_DIR}/matchsettings.xml \
    && mv -v /stadium_map.Map.gbx ${TEMPLATE_DIR}/stadium_map.Map.gbx \
    && echo '@reboot /update-perms.sh >/dev/null 2>&1' >> /etc/crontabs/root \
    && chmod +x -v ${WORKDIR}/ManiaPlanetServer /entrypoint.sh /update-perms.sh \
    && chown -R ${USER}:${USER} ${WORKDIR} \
    && apk del unzip libstdc++ \
    && rm -rfv -- ${WORKDIR}/*.bat ${WORKDIR}/*.exe ${WORKDIR}/*.html ${WORKDIR}/RemoteControlExamples \
    && rm -rfv /tmp/* /var/tmp/* /var/cache/apk/* \
    ;

EXPOSE 2350 2350/udp 3450 3450/udp 5000
VOLUME ${WORKDIR}
USER ${USER}
WORKDIR ${WORKDIR}
ENTRYPOINT ["/entrypoint.sh"]
