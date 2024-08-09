{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "leechcore";
  version = "2.18.7";

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "leechcore";
    rev = "3eff4c5b079e8aaff9d5392bc698de7cb4a05b5d"; # v2.18.7
    hash = "sha256-60yQmx3ZcjaWgUzA1l+F3frPAyrJcr2ihf/zKXWz+t0=";
  };
  # sourceRoot = "${src.name}/leechcore";

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
