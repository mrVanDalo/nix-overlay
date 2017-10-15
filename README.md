# My Nixpkgs 

This is an experiment area

## How to build something

    nix-build -E 'with import <nixpkgs> {} ; callPackage ./slack-bin.nix {}';
