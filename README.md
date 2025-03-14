This repo holds a nix-channel with some packages I need but don't want to maintain.

Notable packages:
- [memprocfs](./pkgs/memprocfs/README.md)
- [pcileech](./pkgs/pcileech/README.md)
- [sugarcube](./pkgs/sugarcube/README.md)

## Usage example
`nix run`
```sh
$ nix run github:holly-hacker/nixpkgs#pcileech
```

`flake.nix`
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
