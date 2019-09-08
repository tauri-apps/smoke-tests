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
Assuming you have cargo and rust installed. If not, see below/

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

## Add Rust and Build Toolchain

### Windows 64 or 32 bit
You will need to have Visual Studio and windows-build-tools installed.

First visit the [Microsoft docs](https://docs.microsoft.com/en-us/visualstudio/install/install-visual-studio?view=vs-2019) and install Visual Studio.
```bash
$ npm install --global windows-build-tools
```

If you are running Windows 64-bit, download and run [rustup‑init.exe](https://win.rustup.rs/x86_64) and then follow the onscreen instructions.

If you are running Windows 32-bit, download and run [rustup‑init.exe](https://win.rustup.rs/i686) and then follow the onscreen instructions.

### Arch
According to the Arch manual, this is something you were born knowing. But seriously, if you want to help out explaining how newbies to Arch can do this, please feel free to make a PR to this doc.

### BSD
Similar to Arch, you already have everything installed because you compile kernels. However:
- Execution on OpenBSD requires wxallowed mount(8) option.
- FreeBSD is also supported, to install webkit2 run pkg install webkit2-gtk3.

### Ubuntu
First install Ubuntu then:
```bash
$ sudo apt update && sudo apt install libwebkit2gtk-4.0-dev build-essential
```

### MacOS
```bash
$ brew install gcc
```

### Everybody except Windows
```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

> We have audited this bash script, and it does what it says it is supposed to do. Nevertheless, before blindly curl-bashing a script, it is always wise to look at it first. Here is file as a mere [download link](https://sh.rustup.rs)

Make sure that `rustc` and `cargo` are in your $PATH. Run
```bash
$ rustc --version
latest update on 2019-07-04, rust version 1.37.0
```
and make sure you are on latest update on 2019-07-04, rust version 1.37.0 - otherwise be sure to update.

```
$ rustup update stable
$ rustup override set 1.37.0
```


## About `rustup` (from their [website](https://rustup.rs))
`rustup` installs rustc, cargo, rustup and other standard tools to Cargo's bin directory. On Unix it is located at `$HOME/.cargo/bin` and on Windows at `%USERPROFILE%\.cargo\bin`. This is the same directory that cargo install will install Rust programs and Cargo plugins.

This directory will be in your `$PATH` environment variable, which means you can run them from the shell without further configuration. **Open a new shell** and type the following:

```bash
$ rustc --version
```
or run:

```bash
source $HOME/.cargo/env

# and then

$ rustc --version
```

If you don't see 1.37.0 or later, then you'll need to upgrade your rust.
 
```bash
$ rustup update stable
$ rustup override set 1.37.0
```

### bundler
After you have installed Rust and the build toolchain, it is wise to open a new shell before continuing.

Setup the bundler:
```bash
$ cargo install --path node_modules/@quasar/tauri/tools/rust/cargo-tauri-bundle --force
```

Want to debug?
#### *nix

```bash
$ cd src-tauri
$ RUST_DEBUG=1 cargo build
```

#### Windows

```bash
$ cd src-tauri
$ set RUST_DEBUG=1
$ cargo build
```


## experimental anti-bloat features

see: https://github.com/RazrFalcon/cargo-bloat

add this to your `/src-tauri/Cargo.toml` (currently being used in the /test project)
```
[profile.release]
panic = "abort"
codegen-units = 1
lto = true
```

## error reporting
Please report all library errors at https://github.com/tauri-apps/tauri 

## License
Everything in this repo is MIT License unless otherwise specified. The TodoMVC projects are also Copyright (c) Addy Osmani, Sindre Sorhus, Pascal Hartig, Stephen Sawchuk and the respective authors.
