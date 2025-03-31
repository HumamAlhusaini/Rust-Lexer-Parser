
(* The type of tokens. *)

type token = 
  | SEMICOLON
  | RPAREN
  | RBRACE
  | MUT
  | LPAREN
  | LET
  | LBRACE
  | INT of (int)
  | IDENT of (string)
  | FN
  | EQ
  | EOF
  | ARROW

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
