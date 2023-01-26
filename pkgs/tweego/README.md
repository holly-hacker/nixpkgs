# Tweego

Tweego is a free (gratis and libre) command line compiler for Twine/Twee story formats, written in Go.

- Source repository: [tmedwards/tweego](https://github.com/tmedwards/tweego).

## Example usage

Tweego requires a story format to be present. While you can use a local story format, you can also use
[SugarCube 2](../sugarcube/README.md):

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
