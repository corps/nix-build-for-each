{ pkgs ? import <nixpkgs> {}
, bash ? pkgs.bash
, stdenv ? pkgs.stdenv
}:

stdenv.mkDerivation {
  name = "nix-build-for-each";
  src = ./.;
  buildInputs = [ bash ];

  installPhase = ''
    mkdir -p $out/bin/
    chmod +x nix-*
    cp nix-* $out/bin/
  '';
}
