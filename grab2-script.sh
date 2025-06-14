#!/bin/bash
cd /epg
npm run grab -- --channels=custom.channels2.xml --output=public/guide2.xml --maxConnections=${MAX_CONNECTIONS} --days=${DAYS} --delay=${DELAY} --timeout=${TIMEOUT}