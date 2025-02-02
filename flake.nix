{
  description = "A collection of packages for the Nix package manager";
  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/13fe00cb6c75461901f072ae62b5805baef9f8b2.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      callPackage = pkgs.lib.callPackageWith (pkgs // self);
    in
    {
      packages = import ./default.nix { inherit system pkgs; };
    }
  );
}
