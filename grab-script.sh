#!/bin/bash
npm run grab -- --channels=custom.channels.xml --output=public/guide.xml --maxConnections=${MAX_CONNECTIONS} --days=${DAYS} --delay=${DELAY} --timeout=${TIMEOUT} &&
mv /epg/channels.m3u /epg/public/channels.m3u