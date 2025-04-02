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

let main () =
  let lexbuf = Lexing.from_string "fn helloWorld() {
    printf('Hello World')
    }" in
  let token_list = get_token_list lexbuf in
  List.map pp_token token_list |> List.iter (printf "%s\n")

let () = main () (* Add this line to call the main function *)
