open Printf
open Lex
open Ast

let string_list_to_string (lst : string list) (separator : string) : string =
  String.concat separator lst

let rec string_of_expr (e : expr) : string =
  match e with
  | Func (name, param, body) -> Printf.sprintf "Function(%s) Param(%s) Body{%s}" name (string_list_to_string param ",")  (string_of_expr body)
  | Int i -> Printf.sprintf "Integer(%d)" i
  | Print str -> Printf.sprintf "Print(%s)" str
  | Binop (op, e1, e2) ->
    let op_str = 
      match op with
      | Add -> "+"
      | Mult -> "*"
    in
    Printf.sprintf "Binop(%s, %s, %s)" op_str (string_of_expr e1) (string_of_expr e2)


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
    let ast = Parser.prog Lexer.token lexbuf in
    close_in ic;
    printf "%s\n" (string_of_expr ast);

 with
  | Sys_error err ->
      eprintf "Error: %s\n" err;
      exit 1
  | Lexer.SyntaxError msg ->
      eprintf "Lexing error: %s\n" msg;
      exit 1
  | Parser.Error ->
      eprintf "Parsing error\n";
      exit 1

let () =
  if Array.length Sys.argv <> 2 then
    eprintf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    main Sys.argv.(1)


