#!/bin/bash
cd /epg
npm run grab -- --channels=custom.channels3.xml --output=public/guide3.xml --maxConnections=${MAX_CONNECTIONS} --days=${DAYS} --delay=${DELAY} --timeout=${TIMEOUT}