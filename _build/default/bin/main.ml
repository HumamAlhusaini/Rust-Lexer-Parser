open Printf
open Token 

let get_token_list lexbuf =
  let rec work acc =
    match Lexer.token lexbuf with
    | EOF -> acc
    | t -> work (t :: acc)
  in
  List.rev (work [])

let pp_token = function
  | ADD -> "ADD"
  | MULT -> "MULT"
  | INT i -> Printf.sprintf "INT(%d)" i
  | EOF -> "EOF"
  | FUNC -> "FUNC"
  | STRUCT -> "STRUCT"
  | ID s -> Printf.sprintf "ID(%s)" s
  | LBRAC -> "LBRAC"
  | RBRAC -> "RBRAC"
  | RPAREN -> "RPAREN"
  | LPAREN -> "LPAREN"
  | PRINTF -> "PRINTF"
  | STRING s -> Printf.sprintf "STRING(%s)" s
  | COMMA -> "COMMA"
  | SEMICOLON -> "SEMICOLON"

let main filename =
  try
    let ic = open_in filename in
    let lexbuf = Lexing.from_channel ic in
    let token_list = get_token_list lexbuf in
    List.map pp_token token_list |> List.iter (printf "%s\n");
    close_in ic
  with Sys_error err ->
    eprintf "Error: %s\n" err;
    exit 1

let () =
  if Array.length Sys.argv <> 2 then
    eprintf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    main Sys.argv.(1)
