{ pkgs ? import <nixpkgs> {} }:

with pkgs;

buildGoPackage rec {
  pname = "tweego";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "tmedwards";
    repo = "tweego";
    rev = "v${version}";
    sha256 = "sha256-LE85mSByTz7uFjs0XtrpfD7OARoMPE56FpjFw+FlGYw=";
  };

  # for buildGoPackage
  goPackagePath = "github.com/tmedwards/tweego";
  goDeps = ./goDeps.nix;

  meta = with lib; {
    description = "Tweego is a free (gratis and libre) command line compiler for Twine/Twee story formats, written in Go.";
    homepage = "https://www.motoslave.net/tweego/";
    license = licenses.bsd2;
    maintainers = [];
  };
}
