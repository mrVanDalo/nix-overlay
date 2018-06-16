# This overlay extends nixpkgs .
self: super:

let
  callPackage = super.lib.callPackageWith super;
in

{
  #darktable = callPackage ./pkgs/darktable {
  #  inherit (super.gnome2) GConf libglade;
  #  pugixml = super.pugixml.override { shared = true; };
  #  inherit (super.xorg) libXau libXdmcp libpthreadstubs libxcb libxshmfence;
  #};

  memo = callPackage ./pkgs/memo {};

  pencil = callPackage ./pkgs/pencil {};

  timewarrior = callPackage ./pkgs/timewarrior {};

  ctmg = callPackage ./pkgs/ctmg{};

  nerdfonts = callPackage ./pkgs/nerdfonts{};

  # vcvrack
  # -------
  blendish = callPackage ./pkgs/vcvrack/lib/blendish.nix {
    inherit (super.xorg) libX11 libXau libXdmcp libXrandr libXext libXinerama libXcursor libpthreadstubs ;
    nanovg = self.nanovg;
  };
  glew21   = callPackage ./pkgs/vcvrack/lib/glew.nix {
    inherit (super.xorg) libXmu libXi;
  };
  glfw-git = callPackage ./pkgs/vcvrack/lib/glfw.nix {
    libGL = super.mesa_glu ;
    inherit (super.xorg) libX11 libXrandr libXinerama libXcursor;
  };
  nanosvg  = callPackage ./pkgs/vcvrack/lib/nanosvg.nix {
    inherit (super.xorg) libX11 libXau libXdmcp libXrandr libXext libXinerama libXcursor libpthreadstubs ;
  };
  nanovg   = callPackage ./pkgs/vcvrack/lib/nanovg.nix {};
  osdialog = callPackage ./pkgs/vcvrack/lib/osdialog.nix {};
  rtaudio5 = callPackage ./pkgs/vcvrack/lib/rtaudio.nix {};
  rtmidi3  = callPackage ./pkgs/vcvrack/lib/rtmidi.nix {};
  vcvrack  = callPackage ./pkgs/vcvrack {
    blendish = self.blendish ;
    glew     = self.glew21;
    glfw     = self.glfw-git;
    nanosvg  = self.nanosvg ;
    nanovg   = self.nanovg ;
    osdialog = self.osdialog ;
    rtaudio  = self.rtaudio5;
    rtmidi   = self.rtmidi3;
  };


  # bitwig
  # ------
  bitwig-studio1 = callPackage ./pkgs/bitwig-studio/bitwig-studio1.nix {
    inherit (super.gnome2) zenity;
  };
  bitwig-studio2 = callPackage ./pkgs/bitwig-studio/bitwig-studio2.nix {
    inherit (super.gnome2) zenity;
    inherit (self) bitwig-studio1;
  };
  bitwig-studio = callPackage ./pkgs/bitwig-studio/bitwig-studio-environment.nix {};


}
