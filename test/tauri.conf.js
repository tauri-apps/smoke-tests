const
  path = require('path'),
  // distDir = path.resolve(__dirname, '../quasar/compiled-web')
  distDir = path.resolve(__dirname, '../todomvc/vanillajs/monolith')

module.exports = function () {
  return {
    dev: {
    },
    build: {
      distDir: distDir,
      APP_URL: 'http://localhost:4000'
    },
    ctx: {},
    tauri: {
      embeddedServer: {
        active: true
      },
      bundle: {
        active: true
      },
      whitelist: {
        all: false
      },
      window: {
        title: "Tauri App"
      },
      security: {
        csp: 'default-src data: filesystem: ws: http: https: \'unsafe-eval\' \'unsafe-inline\''
      }
    }
  }
}
