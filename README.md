# My Nixpkgs 

This is an experiment area

## How to build something

    nix-build -E 'with import <nixpkgs> {} ; callPackage ./slack-bin.nix {}';

## How to use in configuration.nix

add the following to your `/etc/nixos/configuration.nix`:

    nixpkgs.config.packageOverrides = import /path/to/overlay.nix pkgs;

now you can install the packages from the overlay

    environment.systemPackages = [
        pkgs.memo
    ];
