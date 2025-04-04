type bop = 
  | Add
  | Mult

type expr =
  | Int of int
  | Binop of bop * expr * expr
  | Func of string * string list * expr list
  | Print of string

type program = Program of expr list
