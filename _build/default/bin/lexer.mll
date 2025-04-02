{
  open Token
}

let digits = ['0'-'9']+

rule token = parse
 [' ' '\t' '\n']
    {token lexbuf}
| '+' {ADD}
| '*' {MULT}
| digits as lxm {INT (int_of_string lxm)}
| eof { EOF }
