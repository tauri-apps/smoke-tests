# smoke-tests [WIP]
A collection of frameworks used as a suite of smoke-tests for tauri

## Basic Tests
The `todomvc` folder is composed of baseline apps from the [todomvc](https://github.com/tastejs/todomvc) projects. At the moment we're building:
 - angular2
 - polymer
 - react
 - vanillajs

They have not been modified in any way.

## vanillajs/monolith
This is a hand-made monolithic html file. It should be good to just drop in. Soon we'll have a webpack and babel approach to do this as well.

## vanillajs/duolith
This splits the monolith into an `index.html` and `js/app.js` files

## test-drive
```bash
$ git clone https://github.com/tauri-apps/smoke-tests
$ cd smoke-tests/test
$ yarn
$ cargo install --path node_modules/@quasar/tauri/tools/rust/cargo-tauri-bundle --force
$ yarn tauri build
```
After tauri has compiled its rust resources, look in the `src-tauri/target/release/bundle`.

Currently available in `test/binaries`:
- [x] MacOS app
- [ ] Windows exe
- [ ] Linux deb

## error reporting
Please report all library errors at https://github.com/tauri-apps/tauri 

## License
Everything in this repo is MIT License unless otherwise specified. The TodoMVC projects are also Copyright (c) Addy Osmani, Sindre Sorhus, Pascal Hartig, Stephen Sawchuk and the respective authors.
