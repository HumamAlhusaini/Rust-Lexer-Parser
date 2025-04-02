open Printf
open Lex
open Token 
open Pprinter

let get_token_list lexbuf =
  let rec work acc =
    match Lexer.token lexbuf with
    | EOF -> acc
    | t -> work (t :: acc)
  in
  List.rev (work [])

let main filename =
  try
    printf "%s\n" filename;
    let ic = open_in filename in
    let lexbuf = Lexing.from_channel ic in
    let token_list = get_token_list lexbuf in
    List.map pp_token token_list |> List.iter (printf "%s\n");
    close_in ic
  with Sys_error err ->
    eprintf "Error: %s\n" err;
    exit 1

let () = main "/home/humam/Projects/rsToClight/test/sample.rs"
