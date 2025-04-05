%{
open Ast
%}

%token ADD MULT SUB DIV MOD         
%token EQ                           
%token LT GT LTE GTE ISEQUAL NEQ    
%token AND OR NOT                   
%token LPAREN RPAREN LBRAC RBRAC    
%token COMMA SEMICOLON              
%token FUNC                         
%token STRUCT                       
%token RETURN                       
%token IF ELSE                      
%token WHILE                        
%token LET                          
%token I32 F64 BOOL                 
%token TRUE FALSE                   
%token EOF                          

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
    | FUNC; e = ID; LPAREN; param = separated_list(COMMA, ID); RPAREN;
    LBRAC; e1 = list(expr); RBRAC {Func ($startpos, e, param, e1)}
    | m = macro { m }
    | b1 = binoperands; bin = binop; b2 = binoperands { Binop ($startpos, bin, b1, b2) }

macro:
|  PRINTF; LPAREN; str = STRING; RPAREN; SEMICOLON {Print ($startpos, str)}

binoperands:
    | i = ID { Id i }
    | i = INT { Int i }
    | str = STRING { String str }
    | b = TRUE { Bool true}
    | b = FALSE { Bool false}


(*    Statement:
       | Item
       | LET * ID * 
       | ExpressionStatement
       | MacroInvocationSemi
*)

(*
    Syntax:
    Item:
       OuterAttribute*
          VisItem
       | MacroItem

    VisItem:
       Visibility?
       (
             Module
          | ExternCrate
          | UseDeclaration
          | Function
          | TypeAlias
          | Struct
          | Enumeration
          | Union
          | ConstantItem
          | StaticItem
          | Trait
          | Implementation
          | ExternBlock
       )

    MacroItem:
          MacroInvocationSemi
       | MacroRulesDefinition
 *)

(*
Expression :
      ExpressionWithoutBlock
   | ExpressionWithBlock

ExpressionWithoutBlock :
   OuterAttribute*†
   (
         LiteralExpression
      | PathExpression
      | OperatorExpression
      | GroupedExpression
      | ArrayExpression
      | AwaitExpression
      | IndexExpression
      | TupleExpression
      | TupleIndexingExpression
      | StructExpression
      | CallExpression
      | MethodCallExpression
      | FieldExpression
      | ClosureExpression
      | AsyncBlockExpression
      | ContinueExpression
      | BreakExpression
      | RangeExpression
      | ReturnExpression
      | UnderscoreExpression
      | MacroInvocation
   )

ExpressionWithBlock :
   OuterAttribute*†
   (
         BlockExpression
      | ConstBlockExpression
      | UnsafeBlockExpression
      | LoopExpression
      | IfExpression
      | IfLetExpression
      | MatchExpression
   )
 *)
