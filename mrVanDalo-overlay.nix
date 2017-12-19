# This overlay extends nixpkgs .
self: super:

let
  callPackage = super.lib.callPackageWith super;
in

{
  newpencil = callPackage ./pkgs/newpencil { };
}
