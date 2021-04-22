# Flutter Tauri Example

A basic 2048 game written with Flutter and transpiled for the web.

To run, get the flutter sdk and execute `flutter build web`.  If you want to just build and serve the flutter app via a chrome you can run `flutter run -d chrome`.  To run on the experimental webserver, use `flutter run -d web-server`.

> https://flutter.dev/docs/get-started/install

```
flutter config --enable-web
flutter channel dev
flutter build web
```

To build the tauri app, make sure to get the tauri-bundler with `cargo install tauri-bundler`.  Also install Tauri either by installing it locally or globally with yarn or npm. Run `tauri build prod` to build a production build of the application.
