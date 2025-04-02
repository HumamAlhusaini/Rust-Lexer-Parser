open Printf
open Lexer

let get_token_list lexbuf =
  let rec work acc =
    match Lexer.token lexbuf with
    | EOF -> acc
    | t -> work (t :: acc)
  in
  List.rev (work [])

let main () =
  let lexbuf = Lexing.from_string "10 + 2 * 3" in
  let token_list = get_token_list lexbuf in
  Printf.printf "Length %d\n" (List.length token_list)

let () = main () (* Add this line to call the main function *)
