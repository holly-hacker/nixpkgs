{
  description = "A collection of packages for the Nix package manager";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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
