{ pkgs ? import <nixpkgs> {}
, memprocfs
, leechcore-plugin-ft601-driver-linux
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "pcileech";
  version = "4.19";

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "pcileech";
    rev = "v4.19";
    hash = "sha256-ksykFKCoKabgkW0olAgoPBu2BT8Oz7crG12qDdkYsG8=";
  };

  nativeBuildInputs = [ 
    fuse
   ];

  patches = [ ./more-benchmarks-sizes.patch ];

  installPhase = ''
    cp ${memprocfs}/lib/leechcore.so ./files/
    cp ${memprocfs}/lib/vmm.so ./files/
    cp ${leechcore-plugin-ft601-driver-linux}/lib/leechcore_ft601_driver_linux.so ./files/

    cd pcileech
    make

    mkdir -p $out/lib/
    cp ../files/leechcore.so $out/lib/
    cp ../files/leechcore_ft601_driver_linux.so $out/lib/
    cp ../files/vmm.so $out/lib/
    mkdir -p $out/bin/
    cp ../files/pcileech $out/bin/
  '';

  meta = with lib; {
    description = "Direct Memory Access (DMA) Attack Software";
    homepage = "https://github.com/ufrisk/pcileech";
    license = licenses.agpl3Only;
    maintainers = [];
  };
}
