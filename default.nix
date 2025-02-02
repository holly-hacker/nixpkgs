{ system ? builtins.currentSystem, pkgs }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    leechcore = callPackage ./pkgs/leechcore/package.nix {};
    leechcore-plugin-ft601-driver-linux = callPackage ./pkgs/leechcore-plugin-ft601-driver-linux/package.nix {};
    libmicrovmi = callPackage ./pkgs/libmicrovmi/package.nix {};
    memprocfs = callPackage ./pkgs/memprocfs/package.nix {};
    pcileech = callPackage ./pkgs/pcileech/package.nix {};
    pico-sdk-2 = callPackage ./pkgs/pico-sdk-2/package.nix {};
    picotool-2 = callPackage ./pkgs/picotool-2/package.nix {};
    sugarcube = callPackage ./pkgs/sugarcube/package.nix {};
    tweego = callPackage ./pkgs/tweego/package.nix {};
  };
in
self
