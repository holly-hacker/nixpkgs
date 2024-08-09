{ pkgs ? import <nixpkgs> {}
, leechcore
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "memprocfs";
  version = "5.11.4";

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "memprocfs";
    rev = "5a50667933c87f542e9bd34f7d438b8603e29bc0"; # v5.11.4
    hash = "sha256-1Pwql4yzV+hLPy1/tc2vhj/GE/LS0Lda/1Eq9eJslHI=";
  };
  # sourceRoot = "${src.name}/memprocfs";

  nativeBuildInputs = [
    pkg-config
    lz4
    fuse
    python3
  ];

  installPhase = ''
    cp ${leechcore}/lib/leechcore.so ./files/
    cd vmm
    make
    cd ../memprocfs
    make
    cd ../vmmpyc
    make

    mkdir -p $out/lib/
    cp ../files/leechcore.so $out/lib/
    cp ../files/vmm.so $out/lib/
    cp ../files/vmmpyc.so $out/lib/
    mkdir -p $out/bin
    cp ../files/memprocfs $out/bin
  '';

  meta = with lib; {
    description = "MemProcFS";
    homepage = "https://github.com/ufrisk/memprocfs";
    license = licenses.agpl3Only;
    maintainers = [];
  };
}
