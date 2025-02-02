{ system ? builtins.currentSystem, pkgs }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    leechcore = callPackage ./pkgs/leechcore/package.nix {};
    leechcore-plugin-ft601-driver-linux = callPackage ./pkgs/leechcore-plugin-ft601-driver-linux/package.nix {};
    libmicrovmi = callPackage ./pkgs/libmicrovmi/package.nix {};
    memprocfs = callPackage ./pkgs/memprocfs/package.nix {};
    pcileech = callPackage ./pkgs/pcileech/package.nix {};
    sugarcube = callPackage ./pkgs/sugarcube/package.nix {};
  };
in
self
