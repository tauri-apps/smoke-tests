const
  path = require('path'),
  // distDir = path.resolve(__dirname, '../smoke/quasar/compiled-web')
  distDir = path.resolve(__dirname, '../smoke/todomvc/vanillajs/monolith')
  // distDir = path.resolve(__dirname, '../smoke/yew/monolith')
  // distDir = path.resolve(__dirname, './src-tauri/compiled-web')

module.exports = function () {
  return {
    dev: {
    },
    build: {
      distDir: distDir,
      APP_URL: 'http://localhost:4000/'
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
