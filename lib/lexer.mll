{
  open Lexing
  open Parser

exception SyntaxError of string

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos;
               pos_lnum = pos.pos_lnum + 1
    }
}


let digits = ['0'-'9']+
let alpha = ['a'-'z' 'A'-'Z']
let id = (alpha) (alpha|digits|'_')* (* regex for identifier *)
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule token = parse
  [' ' '\t' '\n' '\r'] { token lexbuf }
| '+'  { ADD }
| '-'  { SUB }
| '*'  { MULT }
| '/'  { DIV }
| '%'  { MOD }
| "==" { ISEQUAL }
| "!=" { NEQ }
| "<=" { LTE }
| ">=" { GTE }
| "<"  { LT }
| ">"  { GT }
| "&&" { AND }
| "||" { OR }
| "!"  { NOT }
| "&"  { AMPERSAND } (* or BAND, depending on context *)
| "|"  { BOR }
| "^"  { XOR }
| "~"  { BNOT }
| "<<" { LSHIFT }
| ">>" { RSHIFT }
| "+=" { PLUSEQ }
| "-=" { MINUSEQ }
| "*=" { MULTEQ }
| "/=" { DIVEQ }
| "%=" { MODEQ }
| "&=" { BANDEQ }
| "|=" { BOREQ }
| "^=" { XOREQ }
| "<<=" { LSHIFTEQ }
| ">>=" { RSHIFTEQ }
| "true" { TRUE }
| "false"{ FALSE }
| digits as lxm { INT (int_of_string lxm) }
| "fn" { FUNC }
| '"'  { read_string (Buffer.create 17) lexbuf }
| "'static" { STATIC }
| "(" { LPAREN }
| ")" { RPAREN }
| "{" { LBRAC }
| "}" { RBRAC }
| "," { COMMA }
| "print!" { PRINTF }
| ";" { SEMICOLON }
| ":" { COLON }
| "str" { STR }
| "//" { read_single_line_comment lexbuf }
| '='  { EQUALS }
| '.'  { PERIOD }
| "let" { LET }
| "i32" { I32 }
| "u32" { U32 }
| "i64" { I64 }
| "u64" { U64 }
| "f32" { F32 }
| "f64" { F64 }
| "bool" { BOOL }
| "'" { SINGLE_QUOTE }
| "mut" { MUT }
| "if" { IF }
| "else" { ELSE }
| "while" { WHILE }
| "for" { FOR }
| "in" { IN }
| "break" { BREAK }
| "continue" { CONTINUE }
| "return" { RETURN }
| "match" { MATCH }
| "=>" { FAT_ARROW }
| "_" { UNDERSCORE }
| "::" { DOUBLE_COLON }
| "#" { HASH }
| "@" { AT }
| "$" { DOLLAR }
| "?" { QUESTION }
| "as" { AS }
| "use" { USE }
| "crate" { CRATE }
| "mod" { MOD }
| "pub" { PUB }
| "impl" { IMPL }
| "trait" { TRAIT }
| "type" { TYPE }
| "enum" { ENUM }
| "const" { CONST }
| "static" { STATIC_KEYWORD } (* to distinguish from 'static lifetime *)
| "unsafe" { UNSAFE }
| "extern" { EXTERN }
| "async" { ASYNC }
| "await" { AWAIT }
| "try" { TRY }
| "box" { BOX }
| "arc" { ARC }
| "rc" { RC }
| "Vec" { VEC }
| "Option" { OPTION }
| "Result" { RESULT }
| "self" { SELF_KEYWORD } (* to distinguish from SELF type *)
| "super" { SUPER_KEYWORD } (* to distinguish from SUPER type *)
| "Self" { SELF_TYPE }
| id   { ID (Lexing.lexeme lexbuf) }
| _    { raise ( SyntaxError ("Lexer - Illegal character: " ^ Lexing.lexeme lexbuf)) }
| eof  { EOF }

and read_string buf = parse
  | '"'      { STRING (Buffer.contents buf) }
  | '\\' 'n' { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }

and read_single_line_comment = parse
  | newline { next_line lexbuf; token lexbuf }
  | eof { EOF }
  | _ { read_single_line_comment lexbuf }
