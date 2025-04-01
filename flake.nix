{
  description = "Rust Parser in OCaml with Coq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.ocaml
            pkgs.opam
            pkgs.dune_3
            pkgs.ocamlPackages.findlib
          ];
          };
      }
    );
}
