
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | PLUS
    | INT of (
# 1 "bin/rust_parser.mly"
       (int)
# 16 "bin/rust_parser.ml"
  )
    | EOF
  
end

include MenhirBasics

type ('s, 'r) _menhir_state

and _menhir_box_main = 
  | MenhirBox_main of (int) [@@unboxed]

let _menhir_action_1 =
  fun _1 _3 ->
    (
# 14 "bin/rust_parser.mly"
                 ( _1 + _3 )
# 34 "bin/rust_parser.ml"
     : (int))

let _menhir_action_2 =
  fun _1 ->
    (
# 11 "bin/rust_parser.mly"
             ( _1 )
# 42 "bin/rust_parser.ml"
     : (int))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | INT _ ->
        "INT"
    | PLUS ->
        "PLUS"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_0 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PLUS ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | INT _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_3, _1) = (_v_0, _v) in
                  let _v = _menhir_action_1 _1 _3 in
                  (match (_tok : MenhirBasics.token) with
                  | EOF ->
                      let _1 = _v in
                      let _v = _menhir_action_2 _1 in
                      MenhirBox_main _v
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_0 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
