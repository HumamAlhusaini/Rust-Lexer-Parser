exception SyntaxError of string

type token = 
  | ADD
  | MULT
  | INT of int
  | EOF
  | FUNC 
  | STRUCT
  | ID of string
  | LBRAC
  | RBRAC 
  | RPAREN
  | LPAREN 
  | PRINTF
  | STRING of string

