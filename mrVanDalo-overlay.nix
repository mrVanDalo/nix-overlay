# This overlay extends nixpkgs .
self: super:

let
  callPackage = super.lib.callPackageWith super;
in

{
  darktable = callPackage ./pkgs/darktable { 
    inherit (super.gnome2) GConf libglade;
    pugixml = super.pugixml.override { shared = true; };
    inherit (super.xorg) libXau libXdmcp libpthreadstubs libxcb libxshmfence;
  };

  memo = callPackage ./pkgs/memo { };

  pencil = callPackage ./pkgs/pencil { };

  glew21  = callPackage ./pkgs/glew {
    inherit (super.xorg) libXmu libXi;
  };
  rtmidi3 = callPackage ./pkgs/rtmidi { };

  vcvrack = callPackage ./pkgs/vcvrack {
    glew   = self.glew21;
    rtmidi = self.rtmidi3;
  };

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
