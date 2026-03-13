{
  description = "johnchandlerburnham.github.io";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        site-generator = pkgs.haskellPackages.callCabal2nix "site" ./. {};
        site = pkgs.stdenv.mkDerivation {
          name = "johnchandlerburnham-site";
          src = self;
          nativeBuildInputs = [ site-generator ];
          buildPhase = ''
            export HOME=$TMPDIR
            export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
            export LANG=en_US.UTF-8
            site build
          '';
          installPhase = ''
            mkdir -p $out
            cp -r _site/* $out/
          '';
        };
      in {
        packages = {
          inherit site-generator site;
          default = site;
        };

        devShells.default = pkgs.haskellPackages.shellFor {
          packages = p: [ site-generator ];
          nativeBuildInputs = with pkgs; [
            cabal-install
            haskellPackages.haskell-language-server
          ];
        };
      });
}
