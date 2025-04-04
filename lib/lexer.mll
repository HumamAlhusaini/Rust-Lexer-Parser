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
| '"' {read_string (Buffer.create 17) lexbuf}
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
| "(" { LPAREN }
| ")" { RPAREN }
| "{" { LBRAC }
| "}" { RBRAC }
| "," { COMMA }
| "print!" { PRINTF }
| ";" { SEMICOLON }
| "="  { EQUALS }
| "."  { PERIOD }
| "let" { LET }
| "i32" { I32 }
| "u32" { U32 }
| "i64" { I64 }
| "u64" { U64 }
| "f32" { F32 }
| "f64" { F64 }
| "bool" { BOOL }
| "if" { IF }
| "else" { ELSE }
| "while" { WHILE }
| "break" { BREAK }
| "continue" { CONTINUE }
| "return" { RETURN }
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
