type bop = 
  | Add
  | Mult

type expr =
  | Int of int
  | Binop of bop * expr * expr
  | Func of string * string list * expr
  | Print of string

