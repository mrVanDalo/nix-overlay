# NixOs fhs-user script
# ---------------------
#
# this is a script to start Bitwig Studio.
# it is necessary because without my VSTs won't run.


# function header
# ---------------
{ pkgs ? import <nixpkgs> {} }:

# function call
# -------------
(pkgs.buildFHSUserEnv {

  # name of the programm
  # --------------------
  name = "bitwig";

  # targetSystem packages
  # ---------------------
  # these are packages which are compiled for the target
  # system architecture
  targetPkgs = pkgs: with pkgs; [

    # todo : check if they are needed
    coreutils
    curl
    vim
    tig
    ack
    bitwig-studio1
    liblo
    zlib
    fftw
    minixml
    libcxx
    alsaLib
    glibc

    gtk2-x11
    atk
    mesa_glu
    glib
    pango
    gdk_pixbuf
    cairo
    freetype
    fontconfig
    dbus
    xorg.libX11
    xorg.libxcb
    xorg.libXext
    xorg.libXinerama
    xlibs.libXi
    xlibs.libXcursor
    xlibs.libXdamage
    xlibs.libXcomposite
    xlibs.libXfixes
    xlibs.libXrender
    xlibs.libXtst
    xlibs.libXScrnSaver

    gnome3.gconf
    nss
    nspr
    expat
    eudev
  ];

  # multilib packages
  # -----------------
  # these are packages compiled for multiple system
  # architectures (32bit/64bit)
  multiPkgs = pkgs: with pkgs; [
  ];

  # command
  # -------
  # the script which should be run right after starting this enviornment
  runScript = "/usr/bin/bitwig-studio";

  # environment variables
  # ---------------------
  profile = ''
    export TERM="xterm"
  '';

})
