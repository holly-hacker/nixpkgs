{ system ? builtins.currentSystem }:

let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/13fe00cb6c75461901f072ae62b5805baef9f8b2.tar.gz") { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    leechcore = callPackage ./pkgs/leechcore/package.nix {};
    leechcore-plugin-ft601-driver-linux = callPackage ./pkgs/leechcore-plugin-ft601-driver-linux/package.nix {};
    libmicrovmi = callPackage ./pkgs/libmicrovmi/package.nix {};
    memprocfs = callPackage ./pkgs/memprocfs/package.nix {};
    pcileech = callPackage ./pkgs/pcileech/package.nix {};
    sugarcube = callPackage ./pkgs/sugarcube/package.nix {};
    tweego = callPackage ./pkgs/tweego/package.nix {};
  };
in
self
