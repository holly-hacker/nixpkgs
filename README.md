This repo holds a nix-channel with some packages I need but don't want to maintain.

Notable packages:
- [memprocfs](./pkgs/memprocfs/README.md)
- [pcileech](./pkgs/pcileech/README.md)
- [tweego](./pkgs/tweego/README.md)
- [sugarcube](./pkgs/sugarcube/README.md)

## Usage example
`shell.nix`
```nix
{ pkgs ? import <nixpkgs> {} }:

let
  holly-pkgs = import (fetchTarball "https://github.com/holly-hacker/nixpkgs/archive/32408c2193dc217a03fcdafca842722027eba911.tar.gz") { };
in pkgs.mkShell {
  packages = [
    holly-pkgs.tweego
    holly-pkgs.sugarcube
  ];

  shellHook = "export TWEEGO_PATH=${holly-pkgs.sugarcube}/lib/";
}
```
