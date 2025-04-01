%token <int> INT
%token PLUS
%token EOF

%start main
%type <int> main

%%

main:
  | expr EOF { $1 }

expr:
  | INT PLUS INT { $1 + $3 }

