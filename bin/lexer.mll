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

(* Define helper regexes *)
let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let int = '-'? digit+  (* regex for integers *)
let id = (alpha) (alpha|digit|'_')* (* regex for identifier *)
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule read_token = parse 
| "(" { LPAREN }
| ")" { RPAREN }
| "printf" { PRINTF }
| "fn" { FUNC }
| "struct" { STRUCT }
| whitespace { read_token lexbuf }
| "//" { read_single_line_comment lexbuf }
| "/*" { read_multi_line_comment lextbuf }
| int { INT (int_of_string (Lexing.lexeme lexbuf))}
| id { ID (Lexing.lexeme lexbuf)}
| '"' { read_string (Buffer.create 17) lexbuf}
| newline {next_line lexbuf; read_token lexbuf}
| eof { EOF }
| _ {raise (SyntaxError ("Lexer - Illegal Character: " ^ Lexing.lexeme lexbuf))}

and read_single_line_comment = parse
| newline {next_line lexbuf; read_token lexbuf}
| eof {EOF}
| _ {read_single_line_comment lexbuf}

and read_multi_line_comment = parse
  | "*/" { read_token lexbuf }
  | newline { next_line lexbuf; read_multi_line_comment lexbuf }
  | eof { raise (SyntaxError ("Lexer - Unexpected EOF - please terminate your comment.")) }
  | "*" { read_multi_line_comment lexbuf }
  | _ {raise (SyntaxError ("Lexer - Illegal Character: " ^ Lexing.lexeme lexbuf))}

and read_string buf = parse
  | '"'       { STRING (Buffer.contents buf) }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }
