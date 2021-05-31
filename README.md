# Examples

A collection of examples of Tauri apps using frontends written in Rust or JavaScript.

These examples are a great way to see how Tauri works with a variety of frameworks.

Uses the template project of each framework.

## How to run

Ensure that you have read the README of the example to check that your first-time setup is done.

The examples assume that this git repository was cloned in the root of the [tauri repo](https://github.com/tauri-apps/tauri) clone on your machine.
The recommended way of running the examples is using [mask](https://github.com/jakedeichert/mask):

```bash
$ cargo install mask
$ git clone https://github.com/tauri-apps/tauri
$ cd tauri
$ mask prepare
$ mask list smoke-tests # this will show all the examples names
$ mask run smoke-test some-example-name # run an example listed on the previous command
```

## Error reporting

Please report all library errors at https://github.com/tauri-apps/tauri

## License

Everything in this repo is MIT License unless otherwise specified.
