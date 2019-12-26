export default {
  build: {
    distDir: 'dist',
    devPath: 'http://localhost:4000'
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
      title: 'Tauri App'
    },
    security: {
      csp:
        "default-src data: filesystem: ws: http: https: 'unsafe-eval' 'unsafe-inline'"
    },
    edge: {
      active: true
    },
    automaticStart: {
      active: true
    }
  }
}
