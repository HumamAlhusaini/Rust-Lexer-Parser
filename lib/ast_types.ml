
type bin_op =
  | BinOpPlus
  | BinOpMinus
  | BinOpNotEq


  (** Stores the line and position of the token *)
type loc = Lexing.position

type modifier = MConst  (** Immutable *) | MVar  (** Mutable *)

type expr_types =
  | TInt  (** Equivalent to C's `int` *)
  | TFloat  (** Equivalent to C's `float` *)
  | TBool  (** Equivalent to C's `_Bool` *)
  | TChar  (** Equivalent to C's `char` *)
  | TPointer of expr_types  (** Equivalent to C's `T*` *)
  | TArray of expr_types * int  (** Equivalent to C's `T[N]`, must have a known size *)
  | TVoid  (** Equivalent to C's `void` *)
  | TStruct of string  (** Equivalent to C's `struct Name` *)
  | TFunction of expr_types list * expr_types  (** Equivalent to C function types *)

