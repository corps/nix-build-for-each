{ pkgs ? import <nixpkgs> {}
, bash ? pkgs.bash
, stdenv ? pkgs.stdenv
, gnugrep ? pkgs.gnugrep
, makeWrapper ? pkgs.makeWrapper
}:

stdenv.mkDerivation {
  name = "nix-build-for-each";
  src = ./.;
  buildInputs = [ bash gnugrep makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin/
    chmod +x nix-*
    cp nix-* $out/bin/

	  for file in $out/bin/*; do
      wrapProgram $file \
        --prefix PATH ":" "${gnugrep}/bin"
    done
  '';
}
