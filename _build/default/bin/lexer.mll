{
  open Token
}

let digits = ['0'-'9']+
let alpha = ['a'-'z' 'A'-'Z']
let id = (alpha) (alpha|digits|'_')* (* regex for identifier *)
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule token = parse
 [' ' '\t' '\n' '\r']
    {token lexbuf}
| '+' {ADD}
| '*' {MULT}
| digits as lxm {INT (int_of_string lxm)}
| "fn" { FUNC }
| '"'  { read_string (Buffer.create 17) lexbuf }
| "(" { LPAREN }
| ")" { RPAREN }
| "{" { LBRAC }
| "}" { RBRAC }
| "," { COMMA }
| "print!" { PRINTF }
| ";" { SEMICOLON }
| id { ID (Lexing.lexeme lexbuf) }
| _ { raise ( SyntaxError ("Lexer - Illegal character: " ^ Lexing.lexeme lexbuf)) }
| eof { EOF }

and read_string buf = parse
  | '"'       { STRING (Buffer.contents buf) }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }
