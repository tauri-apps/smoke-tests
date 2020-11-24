#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]

mod cmd;

use serde::Serialize;

use std::io::BufRead;

fn get_bin_command(name: &str) -> String {
  tauri::api::command::command_path(
    tauri::api::command::binary_command(name.to_string()).unwrap(),
  )
  .unwrap()
}

fn main() {
  tauri::AppBuilder::new()
    .setup(|webview, _| {
      let mut webview = webview.as_mut();
      let mut webview2 = webview.clone();
      std::thread::spawn(move || {
        // the binaries/logger-${targetTriple} binary will be copied to the same folder as the app's binary
        let logger_binary = get_bin_command("logger");
        println!("{:?}", logger_binary);
        let stdout = std::process::Command::new(logger_binary)
          .stdout(std::process::Stdio::piped())
          .spawn()
          .expect("Failed to spawn packaged node")
          .stdout
          .expect("Failed to get packaged node stdout");

        let reader = std::io::BufReader::new(stdout);

        reader
          .lines()
          .filter_map(|line| line.ok())
          .for_each(|line| {
            tauri::event::emit(
              &mut webview,
              String::from("node"),
              Some(format!("'{}'", line)),
            )
            .expect("failed to emit event");
          });
      });

      tauri::event::listen(String::from("hello"), move |msg| {
        #[derive(Serialize)]
        pub struct Reply {
          pub msg: String,
          pub rep: String,
        }

        let reply = Reply {
          msg: format!("{:?}", msg).to_string(),
          rep: "something else".to_string(),
        };

        tauri::event::emit(
          &mut webview2,
          String::from("reply"),
          Some(serde_json::to_string(&reply).unwrap()),
        )
        .expect("failed to emit event");

        println!("Message from emit:hello => {:?}", msg);
      });
    })
    .build()
    .run();
}
