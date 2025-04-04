open Parser
open Ast
open Printf

(* Pretty print function *)
let pprint_token = function
  | ADD -> "ADD"
  | MULT -> "MULT"
  | EOF -> "EOF"
  | FUNC -> "FUNC"
  | STRUCT -> "STRUCT"
  | LBRAC -> "LBRAC"
  | RBRAC -> "RBRAC"
  | RPAREN -> "RPAREN"
  | LPAREN -> "LPAREN"
  | PRINTF -> "PRINTF"
  | COMMA -> "COMMA"
  | SEMICOLON -> "SEMICOLON"
  | COLON -> "COLON"
  | AMPERSAND -> "AMPERSAND"
  | STR -> "STR"
  | STATIC -> "STATIC"
  | EQ -> "EQUALS"
  | ISEQUAL -> "ISEQUAL"
  | PERIOD -> "PERIOD"
  | SUB -> "SUB"
  | DIV -> "DIV"
  | MOD -> "MOD"
  | LT -> "LT"
  | GT -> "GT"
  | LTE -> "LTE"
  | GTE -> "GTE"
  | NEQ -> "NEQ"
  | AND -> "AND"
  | OR -> "OR"
  | NOT -> "NOT"
  | BAND -> "BAND"
  | BOR -> "BOR"
  | XOR -> "XOR"
  | BNOT -> "BNOT"
  | LSHIFT -> "LSHIFT"
  | RSHIFT -> "RSHIFT"
  | PLUSEQ -> "PLUSEQ"
  | MINUSEQ -> "MINUSEQ"
  | MULTEQ -> "MULTEQ"
  | DIVEQ -> "DIVEQ"
  | MODEQ -> "MODEQ"
  | BANDEQ -> "BANDEQ"
  | BOREQ -> "BOREQ"
  | XOREQ -> "XOREQ"
  | LSHIFTEQ -> "LSHIFTEQ"
  | RSHIFTEQ -> "RSHIFTEQ"
  | TRUE -> "TRUE"
  | FALSE -> "FALSE"
  | LET -> "LET"
  | I32 -> "I32"
  | U32 -> "U32"
  | I64 -> "I64"
  | U64 -> "U64"
  | F32 -> "F32"
  | F64 -> "F64"
  | BOOL -> "BOOL"
  | MUT -> "MUT"
  | IF -> "IF"
  | ELSE -> "ELSE"
  | WHILE -> "WHILE"
  | FOR -> "FOR"
  | IN -> "IN"
  | BREAK -> "BREAK"
  | CONTINUE -> "CONTINUE"
  | RETURN -> "RETURN"
  | MATCH -> "MATCH"
  | ARM -> "ARM"
  | FAT_ARROW -> "FAT_ARROW"
  | UNDERSCORE -> "UNDERSCORE"
  | DOUBLE_COLON -> "DOUBLE_COLON"
  | SINGLE_QUOTE -> "SINGLE_QUOTE"
  | HASH -> "HASH"
  | AT -> "AT"
  | DOLLAR -> "DOLLAR"
  | QUESTION -> "QUESTION"
  | AS -> "AS"
  | USE -> "USE"
  | CRATE -> "CRATE"
  | PUB -> "PUB"
  | IMPL -> "IMPL"
  | TRAIT -> "TRAIT"
  | TYPE -> "TYPE"
  | ENUM -> "ENUM"
  | CONST -> "CONST"
  | STATIC_KEYWORD -> "STATIC_KEYWORD"
  | UNSAFE -> "UNSAFE"
  | EXTERN -> "EXTERN"
  | ASYNC -> "ASYNC"
  | AWAIT -> "AWAIT"
  | TRY -> "TRY"
  | BOX -> "BOX"
  | ARC -> "ARC"
  | RC -> "RC"
  | VEC -> "VEC"
  | OPTION -> "OPTION"
  | RESULT -> "RESULT"
  | SELF -> "SELF"
  | SUPER -> "SUPER"
  | SELF_KEYWORD -> "SELF_KEYWORD"
  | SUPER_KEYWORD -> "SUPER_KEYWORD"
  | SELF_TYPE -> "SELF_TYPE"
  | INT n -> Printf.sprintf "INT(%d)" n
  | ID s -> Printf.sprintf "ID(%s)" s
  | STRING s -> Printf.sprintf "STRING(%s)" s
  | RAW_STRING s -> Printf.sprintf "RAW_STRING(%s)" s
  | CHAR c -> Printf.sprintf "CHAR(%c)" c

let string_list_to_string (lst : string list) (separator : string) : string =
  String.concat separator lst

let rec string_of_expr (e : expr) : string =
  match e with
  | Func (loc, name, param, body) -> Printf.sprintf "LOC: %d Function(%s) Param(%s) Body{%s}"
  loc.pos_lnum name (string_list_to_string param ",")  (String.concat ", " (List.map string_of_expr body)) 
  | Int i -> Printf.sprintf "Integer(%d)" i
  | Print (loc, str) -> Printf.sprintf "LOC: %d Print(%s)" loc.pos_lnum str
  | Binop (loc, op, e1, e2) ->
    let op_str = 
      match op with
      | Add -> "+"
      | Mult -> "*"
    in
    Printf.sprintf "Binop(%d, %s, %s, %s)" loc.pos_lnum op_str (string_of_expr e1) (string_of_expr e2)

let string_of_program (prog : program) = 
  match prog with
  | Program expr_list -> 
      (* Use List.fold_left to accumulate the string representation of each expression *)
      List.fold_left (fun acc expr -> 
        acc ^ (string_of_expr expr) ^ "\n"  (* Concatenate each string with a newline *)
      ) "" expr_list 

let get_token_list lexbuf =
  let rec work acc =
    match Lexer.token lexbuf with
    | EOF -> acc
    | t -> work (t :: acc)
  in
  List.rev (work [])

let print_token_list tokens =
  printf "Tokens:\n";
  List.iter (fun token -> printf "%s\n" (pprint_token token)) tokens
