# SugarCube

SugarCube is a free (gratis and libre) story format for Twine/Twee.

- Source repository: [tmedwards/sugarcube-2](https://github.com/tmedwards/sugarcube-2).

## Usage
This package will place a compiled version of SugarCube at /lib/sugarcube-2.

You can use this package with [Tweego](https://github.com/tmedwards/tweego) in a nix devShell with a flake like so:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    holly-nixpkgs.url = "github:holly-hacker/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, holly-nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        holly-pkgs = import holly-nixpkgs { inherit system pkgs; };
      in
      {
        devShells.default = pkgs.mkShell rec {
          nativeBuildInputs = [];
          buildInputs = [];
          packages = [
            pkgs.tweego
            holly-pkgs.sugarcube
          ];
          shellHook = "export TWEEGO_PATH=${holly-pkgs.sugarcube}/lib/";
        };
      }
    );
}
```
