open Printf
open Lex
open Pprinter


let main filename =
  try
    printf "Processing file: %s\n" filename;

    (* First pass: Read and tokenize *)
    let ic1 = open_in filename in
    let lexbuf1 = Lexing.from_channel ic1 in
    let tokens = get_token_list lexbuf1 in
    close_in ic1; (* Close after lexing *)
    
    print_token_list tokens; (* Pretty-print tokens *)

    (* Second pass: Read and parse *)
    let ic2 = open_in filename in
    let lexbuf2 = Lexing.from_channel ic2 in
    let ast = Parser.prog Lexer.token lexbuf2 in
    close_in ic2; (* Close after parsing *)

    printf "AST: %s\n" (string_of_program ast);
  with
  | Sys_error err ->
      eprintf "Error: %s\n" err;
      exit 1
  | Lexer.SyntaxError msg ->
      eprintf "Lexing error: %s\n" msg;
      exit 1
  | Parser.Error ->
      eprintf "Parsing error\n";
      exit 1

let () = main "/home/humam/Projects/rsToClight/test/sample.rs"


