{ pkgs ? import <nixpkgs> {}
, libmicrovmi
, memprocfs
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "leechcore-plugin-ft601-driver-linux";
  version = "2.16.4"; # current latest version is 2.16.8, but it contains no changes to this plugin

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "LeechCore-plugins";
    rev = "1267e6d74681e338147c03f878b15ba5f32c7fde";
    hash = "sha256-9WgF8qox+IOc+Wr6zugqI1raQlFQ9BOumuO9TC/rRw8=";
  };

  nativeBuildInputs = [ 
    pkg-config
    libusb
    libmicrovmi
   ];

  makeFlags = [ "-C leechcore_ft601_driver_linux" ];

  patches = [ ./fix-buffer-overflow.patch ];

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
