
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
  | COMMA
  | SEMICOLON
  | COLON
  | AMPERSAND
  | STR
  | STATIC
  | EQUALS
  | ISEQUAL
  | PERIOD
  | SUB (* - *)
  | DIV (* / *)
  | MOD (* % *)
  | LT  (* < *)
  | GT  (* > *)
  | LTE (* <= *)
  | GTE (* >= *)
  | NEQ (* != *)
  | AND (* && *)
  | OR  (* || *)
  | NOT (* ! *)
  | BAND (* & *)
  | BOR (* | *)
  | XOR (* ^ *)
  | BNOT (* ~ *)
  | LSHIFT (* << *)
  | RSHIFT (* >> *)
  | PLUSEQ (* += *)
  | MINUSEQ (* -= *)
  | MULTEQ (* *= *)
  | DIVEQ (* /= *)
  | MODEQ (* %= *)
  | BANDEQ (* &= *)
  | BOREQ (* |= *)
  | XOREQ (* ^= *)
  | LSHIFTEQ (* <<= *)
  | RSHIFTEQ (* >>= *)
  | TRUE
  | FALSE
  | LET
  | I32
