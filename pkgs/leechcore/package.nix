{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "leechcore";
  version = "2.21";

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "leechcore";
    rev = "v2.21";
    hash = "sha256-VjRhfkm+rDR5xzs7JCproI3dTQua/edFaJ4VOCdXXzA=";
  };

  nativeBuildInputs = [
    pkg-config
    libusb1
  ];

  installPhase = ''
    cd leechcore
    make
    mkdir -p $out/lib/
    cp ../files/leechcore.so $out/lib/
  '';

  meta = with lib; {
    description = "LeechCore - Physical Memory Acquisition Library & The LeechAgent Remote Memory Acquisition Agent";
    homepage = "https://github.com/ufrisk/leechcore";
    license = licenses.gpl3;
    maintainers = [];
  };
}
