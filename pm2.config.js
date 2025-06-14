module.exports = {
  apps: [
    {
      name: 'serve',
      script: 'npx serve -- public',
      instances: 1,
      watch: false,
      autorestart: true
    },
    {
      name: 'grab',
      script: '/epg/grab-script.sh',
      autorestart: false,
      cron_restart: process.env.CRON || "0 0 * * *",
      env: {
        MAX_CONNECTIONS: process.env.MAX_CONNECTIONS,
        DAYS: process.env.DAYS,
        DELAY: process.env.DELAY,
        TIMEOUT: process.env.TIMEOUT
      }
    },
  ]
}
