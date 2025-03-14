{ pkgs ? import <nixpkgs> {}
, leechcore
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "memprocfs";
  version = "5.14";

  src = fetchFromGitHub {
    owner = "ufrisk";
    repo = "memprocfs";
    rev = "17dcf57c9f739f651d62733f040179b93ec34d6f"; # v5.14
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
