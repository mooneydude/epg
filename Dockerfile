FROM node:22-alpine
ARG GIT_REPO=https://github.com/iptv-org/epg.git
ARG GIT_BRANCH=master
ARG WORKDIR=/epg
ENV TZ=America/Chicago
ENV CRON="0 0 * * *"
ENV CRON2="15 0 * * *"
ENV CRON3="25 0 * * *"
ENV GZIP=false
ENV MAX_CONNECTIONS=1
ENV DAYS=2
ENV TIMEOUT=5000
ENV DELAY=500
RUN apk update \
    # apk add --no-cache tzdata && \
    # ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    # echo ${TZ} > /etc/timezone \
    && apk upgrade --available \
    && apk add --no-cache curl git tzdata bash \
    && npm install -g npm@latest \
    && npm install -g serve \
    && npm install -g pm2 \
    && mkdir -p ${WORKDIR} \
    && git clone --depth 1 -b ${GIT_BRANCH} ${GIT_REPO} ${WORKDIR} \
    && cd ${WORKDIR} \
    && npm install \
    && mkdir -p /public \
    && mkdir -p /etc/crontabs \
    && echo "$CRON2 bash ${WORKDIR}/grab2-script.sh > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontabs/root \
    && echo "$CRON3 bash ${WORKDIR}/grab3-script.sh > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontabs/root \
    && chmod 600 /etc/crontabs/root \
    && apk del git curl \
    && rm -rf /var/cache/apk/*
COPY pm2.config.js ${WORKDIR}
COPY channels.m3u ${WORKDIR}
COPY custom.channels.xml ${WORKDIR}
COPY custom.channels2.xml ${WORKDIR}
COPY custom.channels3.xml ${WORKDIR}
COPY grab-script.sh ${WORKDIR}
COPY grab2-script.sh ${WORKDIR}
COPY grab3-script.sh ${WORKDIR}
WORKDIR ${WORKDIR}
EXPOSE 3000
CMD ["bash", "-c", "busybox crond -f & pm2-runtime start pm2.config.js"]