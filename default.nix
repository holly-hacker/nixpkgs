{ system ? builtins.currentSystem }:

let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/13fe00cb6c75461901f072ae62b5805baef9f8b2.tar.gz") { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    sugarcube = callPackage ./pkgs/sugarcube/package.nix {};
    tweego = callPackage ./pkgs/tweego/package.nix {};
  };
in
self
