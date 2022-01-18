let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [

    Dream.post "/echo" (fun request ->
      let body = Lwt_eio.Promise.await_lwt (Dream.body request) in
      Dream.respond
        ~headers:["Content-Type", "application/octet-stream"]
        body);

  ]
  @@ Dream.not_found
