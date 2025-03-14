{ pkgs ? import <nixpkgs> {}
, libmicrovmi
, memprocfs
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "leechcore-plugin-ft601-driver-linux";
  version = "2.16.8-20240816"; # no explicit versions seem to be defined

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "LeechCore-plugins";
    rev = "56f2d6f689916e8e6cab1eea28f0bb033f2ab70e";
    hash = "sha256-SIUL4e+3whJSB7llyOreNJsEaiuC4rgSHPHowzMu1WU=";
  };

  nativeBuildInputs = [ 
    pkg-config
    libusb1
    libmicrovmi
   ];

  makeFlags = [ "-C leechcore_ft601_driver_linux" ];

  installPhase = ''
    cp ${memprocfs}/lib/leechcore.so ./files/
    cp ${memprocfs}/lib/vmm.so ./files/

    cd leechcore_ft601_driver_linux
    make leechcore_ft601_driver_linux

    mkdir -p $out/lib/
    cp ../files/leechcore_ft601_driver_linux.so $out/lib/
  '';

  meta = with lib; {
    description = "leechcore_ft601_driver_linux";
    homepage = "https://github.com/ufrisk/LeechCore-plugins";
    license = licenses.gpl3;
    maintainers = [];
  };
}
