{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, libusb1, pico-sdk-2 }:

stdenv.mkDerivation rec {
  pname = "picotool-2";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "picotool";
    rev = version;
    sha256 = "sha256-z7EFk3qxg1PoKZQpUQqjhttZ2RkhhhiMdYc9TkXzkwk=";
  };

  buildInputs = [ libusb1 pico-sdk-2 ];
  nativeBuildInputs = [ cmake pkg-config ];
  cmakeFlags = [ "-DPICO_SDK_PATH=${pico-sdk-2}/lib/pico-sdk" ];

  postInstall = ''
    install -Dm444 ../udev/99-picotool.rules -t $out/etc/udev/rules.d
  '';

  meta = with lib; {
    homepage = "https://github.com/raspberrypi/picotool";
    description = "Tool for interacting with RP2040/RP2350 device(s) in BOOTSEL mode, or with an RP2040/RP2350 binary";
    mainProgram = "picotool";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ]; # originally: muscaln
    platforms = platforms.unix;
  };
}
