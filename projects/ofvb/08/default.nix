with import <nixpkgs> {};
  stdenv.mkDerivation rec {
    name = "ocamlProject";
    src = null;
    buildInputs = with ocamlPackages;
    [ ocaml
      opam
      utop
    ];
  }
