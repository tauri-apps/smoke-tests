# Tauri + Yew todomvc

### Requirements

Make sure to have `cargo-make` and `yarn` installed.

If you don't have `cargo-make`, you can install by issuing the following command:

```
cargo install cargo-make
```

### Building

To run the standalone yew todomvc, just run:

```
cargo make run
```

This will install yew dependencies, tauri dependencies and build everything needed.
The first time build should take some time, following builds will be a lot faster.
Once it finishes building, it will also execute the tauri bundled yew todomvc.

### Troubleshooting

In case of any build error, take a look at the file `Makefile.toml` for more details on what is being done.
