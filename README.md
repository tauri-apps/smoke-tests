# Examples
A collection of frameworks used as a suite of smoke-tests for tauri

These examples are a great way to see how Tauri works with a variety of frameworks.

## How to run 
How to run
ensure to read the readme of the example to check that your first-time setup is done.

The examples assume by default that the main Tauri repo is in the root of your drive ( on windows c:/tauri/)

To change a exsample to be self contained:
go to /example/src-tauri/cargo.toml
and change the dependency 
```toml
tauri = { path = "../../../../../tauri", features = [ "edge" ] }
```
to
```toml
tauri = { version = "0.5.1", features = [ "edge" ] }
```


## Error reporting
Please report all library errors at https://github.com/tauri-apps/tauri

## License
Everything in this repo is MIT License unless otherwise specified.
