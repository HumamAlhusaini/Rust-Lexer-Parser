
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
  | U32
  | I64
  | U64
  | F32
  | F64
  | BOOL
  | CHAR of char
  | MUT
  | IF
  | ELSE
  | WHILE
  | FOR
  | IN
  | BREAK
  | CONTINUE
  | RETURN
  | MATCH
  | ARM
  | FAT_ARROW (* => *)
  | UNDERSCORE (* _ *)
  | DOUBLE_COLON (* :: *)
  | SINGLE_QUOTE (* ' *)
  | HASH (* # *)
  | AT (* @ *)
  | DOLLAR (* $ *)
  | QUESTION (* ? *)
  | RAW_STRING of string
  | AS
  | USE
  | CRATE
  | PUB
  | IMPL
  | TRAIT
  | TYPE
  | ENUM
  | CONST
  | STATIC_KEYWORD (* static *)
  | UNSAFE
  | EXTERN
  | ASYNC
  | AWAIT
  | TRY
  | BOX
  | ARC
  | RC
  | VEC
  | OPTION
  | RESULT
  | SELF
  | SUPER
  | SELF_KEYWORD (* self *)
  | SUPER_KEYWORD (* super *)
  | SELF_TYPE
