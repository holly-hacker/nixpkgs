#!/usr/bin/env bash
echo "Running PCIleech"
nix run .#pcileech > /dev/null

echo "Building Sugarcube"
nix build .#sugarcube --no-link

echo "Done!"
