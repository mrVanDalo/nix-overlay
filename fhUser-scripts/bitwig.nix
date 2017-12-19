# NixOs fhs-user script
# ---------------------
#
# this is a script for NixOS users, to start Bitwig.
# It is quite similar to docker or rkt but it uses system libs
# to create a "normal" Linux environment so dynamic links can find
# everything they need.


# function header
# ---------------
{ pkgs ? import <nixpkgs> {} }:

# function call
# -------------
(pkgs.buildFHSUserEnv {

  # name it
  # -------
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
    (bitwig-studio.overrideAttrs (
      oldAttrs: { 
      name = "bitwig-studio-1.3.16";
      src = fetchurl {
            url = "https://downloads.bitwig.com/stable/1.3.16/bitwig-studio-1.3.16.deb";
            sha256 = "0n0fxh9gnmilwskjcayvjsjfcs3fz9hn00wh7b3gg0cv3qqhich8";
          };
      }
    ))
    liblo
    zlib
    fftw
    minixml
    libcxx
    alsaLib

    # the following are needed for building
    #libcxxStdenv
    glibc

    # the following are needed for Sononym run
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

    ladspaPlugins
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
  runScript = "bash";

  # environment variables
  # ---------------------
  profile = ''
    export TERM="xterm"
  '';

}).env
