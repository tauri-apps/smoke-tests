#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]

use serde::Serialize;
use tauri::Manager;

fn main() {
  tauri::Builder::default()
    .setup(|app| {
      let window = app.get_window("main").unwrap();
      let window_ = window.clone();
      std::thread::spawn(move || {
        // the binaries/logger-${targetTriple} binary will be copied to the same folder as the app's binary
        let (mut rx, _child) = tauri::api::process::Command::new_sidecar("logger")
          .expect("failed to setup logger sidecar")
          .spawn()
          .expect("Failed to spawn packaged node");

        tauri::async_runtime::spawn(async move {
          while let Some(event) = rx.recv().await {
            if let tauri::api::process::CommandEvent::Stdout(line) = event {
              window
                .emit("node", Some(format!("'{}'", line)))
                .expect("failed to emit event");
            }
          }
        });
      });

      let window__ = window_.clone();
      window_.listen("hello", move |msg| {
        #[derive(Serialize)]
        pub struct Reply {
          pub msg: String,
          pub rep: String,
        }

        let reply = Reply {
          msg: format!("{:?}", msg).to_string(),
          rep: "something else".to_string(),
        };

        window__
          .emit("reply", Some(serde_json::to_string(&reply).unwrap()))
          .expect("failed to emit event");

        println!("Message from emit:hello => {:?}", msg);
      });
      Ok(())
    })
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
