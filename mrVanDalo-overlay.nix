# This overlay extends nixpkgs .
self: super:

let
  callPackage = super.lib.callPackageWith super;
in

{
  memo = callPackage ./pkgs/memo { };
  pencil = callPackage ./pkgs/pencil { };

  bitwig-studio1 = callPackage ./pkgs/bitwig-studio/bitwig-studio1.nix {
    inherit (super.gnome2) zenity;
  };

  bitwig-studio2 = callPackage ./pkgs/bitwig-studio/bitwig-studio2.nix {
    inherit (super.gnome2) zenity;
    inherit (self) bitwig-studio1;
  };

  bitwig-studio = callPackage ./pkgs/bitwig-studio/bitwig-studio2.nix {
    inherit (super.gnome2) zenity;
    inherit (self) bitwig-studio1;
  };
}
