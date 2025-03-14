{ pkgs ? import <nixpkgs> {}
}:

with pkgs;

rustPlatform.buildRustPackage rec {
  pname = "libmicrovmi";
  version = "0.3.16";

  src = fetchFromGitHub {
    owner = "Wenzel";
    repo = "libmicrovmi";
    rev = "6a026d737dcc87535d7376aa30fd8d24c7fd5c4d"; # v0.3.16
    sha256 = "sha256-aMn1fIMwwDAwniH30UGTf3qAyfngynHkCbw3Xs8cEWw=";
  };

  cargoHash = "sha256-fvLPaTcbVtk9MUM5FfT4TJQMHFMMHewXdP1Hsb7/Dzw=";

  doCheck = false; # disable tests

  installPhase = ''
    mkdir -p $out/lib/
    cp target/${stdenv.hostPlatform.rust.rustcTargetSpec}/release/libmicrovmi.so $out/lib/
    mkdir -p $out/include/
    cp target/${stdenv.hostPlatform.rust.rustcTargetSpec}/release/capi/libmicrovmi.h $out/include/
  '';

  # nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    homepage = "https://wenzel.github.io/libmicrovmi/";
    description = "A cross-platform unified Virtual Machine Introspection API library";
    license = licenses.gpl3;
    maintainers = [ ];
  };
}
