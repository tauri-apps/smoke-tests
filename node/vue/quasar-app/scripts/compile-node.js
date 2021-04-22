const execa = require('execa')
const path = require('path')

async function main () {
  const rustTargetInfo = JSON.parse(
    (
      await execa(
        'rustc',
        ['-Z', 'unstable-options', '--print', 'target-spec-json'],
        {
          env: {
            RUSTC_BOOTSTRAP: 1
          }
        }
      )
    ).stdout
  )
  const platformPostfix = rustTargetInfo['llvm-target']

  await execa(path.resolve(__dirname, '../node_modules/.bin/pkg'), ['src-tauri/scripts/logger.js', '--output', `src-tauri/binaries/logger-${platformPostfix}`])
}

main().catch((e) => {
  throw e
})
