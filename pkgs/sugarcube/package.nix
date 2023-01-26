{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "sugarcube";
  version = "2.36.1";

  src = fetchFromGitHub {
    owner = "tmedwards";
    repo = "sugarcube-2";
    rev = "v2.36.1";
    hash = "sha256-KxZVc4ubhnG+kdSGP6vBhsrwWe1I1XQEsryt8o+zI/o=";
  };

  # sugarcube repo has compiled code in `./dist/`.
  installPhase = ''
    mkdir -p $out/lib/sugarcube-2/
    mv dist/* $out/lib/sugarcube-2/
  '';

  meta = with lib; {
    description = "SugarCube is a free (gratis and libre) story format for Twine/Twee.";
    homepage = "https://www.motoslave.net/sugarcube/";
    license = licenses.bsd2;
    maintainers = [];
  };
}
