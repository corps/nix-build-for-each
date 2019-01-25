{ pkgs ? import <nixpkgs> {}
, stdenv ? pkgs.stdenv
, nix-build-for-each ?  pkgs.callPackage ./. {}
}:

stdenv.mkDerivation {
  name = "nix-build-for-each-tests";
  buildInputs = [ nix-build-for-each ];
  src = ./.;

  buildPhase = ''
    ./run-tests
  '';

  installPhase = ''
    mkdir -p $out
    touch $out/success
  '';
}
