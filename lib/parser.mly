%{
open Ast
%}

%token ADD MULT EOF FUNC STRUCT LBRAC RBRAC RPAREN LPAREN PRINTF COMMA SEMICOLON COLON 
AMPERSAND STR STATIC EQ ISEQUAL PERIOD SUB DIV MOD LT GT LTE GTE NEQ AND OR NOT BAND
BOR XOR BNOT LSHIFT RSHIFT PLUSEQ MINUSEQ MULTEQ DIVEQ MODEQ BANDEQ BOREQ XOREQ LSHIFTEQ 
RSHIFTEQ TRUE FALSE LET I32 U32 I64 U64 F32 F64 BOOL MUT IF ELSE WHILE FOR IN BREAK CONTINUE
E RETURN MATCH ARM FAT_ARROW UNDERSCORE DOUBLE_COLON SINGLE_QUOTE HASH AT DOLLAR QUESTION 
AS USE CRATE PUB IMPL TRAIT TYPE ENUM CONST STATIC_KEYWORD UNSAFE EXTERN ASYNC AWAIT TRY
BOX ARC RC VEC OPTION RESULT SELF SUPER SELF_KEYWORD SUPER_KEYWORD SELF_TYPE

%token <int> INT
%token <string> ID STRING RAW_STRING
%token <char> CHAR


%start <Ast.program> prog
%%

prog:
    | e = list(expr); EOF { Program e }
    ;

binop:
  | ADD { Add }
  | SUB { Minus }
  | MULT { Mult }
  | DIV { Div }
  | MOD { Mod }
  | AND { And }
  | OR { Or }
  | EQ { Eq }
  | NEQ { Neq }
  | LT { Lt }
  | GT { Gt }
  | LTE { Lte }
  | GTE { Gte }
  | BAND { BitAnd }
  | BOR { BitOr }
  | XOR { BitXor }
  | LSHIFT { Lshift }
  | RSHIFT { Rshift }


expr:
    | i = INT { Int i }
    | e1 = expr; bin = binop; e2 = expr { Binop ($startpos, bin, e1, e2)}
    | FUNC; e = ID; LPAREN; param = separated_list(COMMA, ID); RPAREN;
    LBRAC; e1 = list(expr); RBRAC {Func ($startpos, e, param, e1)}
    | m = macro { m }
macro:
|  PRINTF; LPAREN; str = STRING; RPAREN; SEMICOLON {Print ($startpos, str)}

