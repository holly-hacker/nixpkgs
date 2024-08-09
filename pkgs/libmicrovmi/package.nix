{ pkgs ? import <nixpkgs> {}
}:

with pkgs;

rustPlatform.buildRustPackage rec {
  pname = "libmicrovmi";
  version = "0.3.14";

  src = fetchFromGitHub {
    owner = "Wenzel";
    repo = "libmicrovmi";
    rev = "v0.3.14";
    sha256 = "sha256-8BxiJ/4/dmBPrwp71s8E1+IHok+lA4hXMmtCjECnSAM=";
  };

  cargoHash = "sha256-uPzTZdzx2TAUfh5nDGa3UJJeuTjPTVQWdRojbha0ufU=";

  # outputs = [ "out" "dev" ] ++ lib.optionals withDocs [ "doc" ];

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
