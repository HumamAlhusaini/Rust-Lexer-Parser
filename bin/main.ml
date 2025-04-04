open Printf
open Lex
open Pprinter

let print_position lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  Printf.sprintf "Line %d, Column %d" pos.Lexing.pos_lnum (pos.Lexing.pos_cnum - pos.Lexing.pos_bol)

let main filename =
  let lexbuf1 = ref None in  (* Mutable reference for lexbuf1 *)
  let lexbuf2 = ref None in  (* Mutable reference for lexbuf2 *)
  try
    Printf.printf "Processing file: %s\n" filename;

    (* First pass: Read and tokenize *)
    let ic1 = open_in filename in
    let lb1 = Lexing.from_channel ic1 in
    lexbuf1 := Some lb1;  (* Store lexbuf1 in ref *)
    let tokens = get_token_list lb1 in
    close_in ic1; (* Close after lexing *)

    print_token_list tokens; (* Pretty-print tokens *)

    (* Second pass: Read and parse *)
    let ic2 = open_in filename in
    let lb2 = Lexing.from_channel ic2 in
    lexbuf2 := Some lb2;  (* Store lexbuf2 in ref *)
    let ast = Parser.prog Lexer.token lb2 in
    close_in ic2; (* Close after parsing *)

    Printf.printf "AST: %s\n" (string_of_program ast);
  with
  | Sys_error err ->
      Printf.eprintf "Error: %s\n" err;
      exit 1
  | Lexer.SyntaxError msg ->
      (match !lexbuf1 with
       | Some lb -> Printf.eprintf "Lexing error at %s: %s\n" (print_position lb) msg
       | None -> Printf.eprintf "Lexing error: %s\n" msg);
      exit 1
  | Parser.Error ->
      (match !lexbuf2 with
       | Some lb -> Printf.eprintf "Parsing error at %s\n" (print_position lb)
       | None -> Printf.eprintf "Parsing error\n");
      exit 1

let () =
  if Array.length Sys.argv <> 2 then
    eprintf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    main Sys.argv.(1)


