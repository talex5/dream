let echo request response =
  let rec loop () =
    match Dream.read request with
    | None ->
      Dream.close response
    | Some chunk ->
      Dream.write response chunk;
      Dream.flush response;
      loop ()
  in
  loop ()

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [

    Dream.post "/echo" (fun request ->
        Dream.stream request
          ~headers:["Content-Type", "application/octet-stream"]
          (echo request));

  ]
  @@ Dream.not_found
