(** Stores the line and position of the token *)
type loc = Lexing.position

type bop = 
  | Add
  | Minus
  | Mult
  | Div
  | Mod
  | And (* && *)
  | Or  (* || *)
  | Eq  (* == *)
  | Neq (* != *)
  | Lt  (* < *)
  | Gt  (* > *)
  | Lte (* <= *)
  | Gte (* >= *)
  | BitAnd  (* &  *)
  | BitOr   (* |  *)
  | BitXor  (* ^  *)
  | Lshift  (* << *)
  | Rshift  (* >> *)

type assign_op =
  | Assign
  | AddEq | SubEq | MultEq | DivEq | ModEq
  | BitAndEq | BitOrEq | BitXorEq | LshiftEq | RshiftEq

type typ =
  | TInt32 | TInt64 | TUint32 | TUint64
  | TFloat32 | TFloat64 | TBool

type literal = 
  | IntLit of int
  | BoolLit of bool

type expr =
  | Int of int
  | Binop of loc * bop * expr * expr
  | Func of loc * string * string list * expr list
  | Print of loc * string

type stmt =
  | If of loc * expr * stmt * stmt option
  | While of loc * expr * stmt
  | Break
  | Continue
  | Return of expr option
  | ExprStmt of expr
  | Let of loc * string * typ * expr

type program = Program of expr list
