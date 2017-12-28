{ lib, stdenv, fetchFromGitHub, fetchgit, makeWrapper, gcc,
  # buildInputs
  curl, glew, glfw, gnome2, jansson, libsamplerate, libzip,
  pkgconfig, rtaudio, rtmidi,
  ... }:

stdenv.mkDerivation rec {
  name = "vcvrack-${version}";
  version = "0.5.1";

  githubUser = "VCVRack";

  # fetch source
  # ------------
  # need to use fetchgit here to pull submodules as well
  src = fetchgit {
    url    = "https://github.com/${githubUser}/Rack.git";
    rev    = "2c17b654afc7e5c6e8e70f41df9dd3f8ad9dde24";
    sha256 = "0zy1splbir50iz12vlpxbpix1qx6lrjmqyb4fy7nz03sz8dij59a";
  };

  # fetch Plugins
  # -------------
  pluginFundamental = fetchgit {
    url    = "https://github.com/${githubUser}/Fundamental.git";
    rev    = "b54abba8585e39badd44e3c45ab38e1f758f65b7";
    sha256 = "0dawi83463fiml03d1d40r638rnzgxlvc4d1744gdal2rmhrycva";
  };
  pluginBefco = fetchgit {
    url    = "https://github.com/${githubUser}/Befaco.git";
    rev    = "793bc687914526f668fac0a9f0c2e49b225e6b3e";
    sha256 = "0v62ffahybff1ipz85zg30sih56wkfdkbbhs9qz10s6k0nr7i63r";
  };
  pluginESeries = fetchgit {
    url    = "https://github.com/${githubUser}/Eseries.git";
    rev    = "ac990ce18327356dd1840b3a83161d17b2e2e183";
    sha256 = "1kwvbsi5vjljlgs6annh7qkxzakjyhmx05qrfhqk9llxs8r8f0d7";
  };
  pluginAudibleInstruments = fetchgit {
    url    = "https://github.com/${githubUser}/AudibleInstruments.git";
    rev    = "715f9770d34acff33d117cda195b1514188cbbdb";
    sha256 = "0paj9iryx3xd46ilipsyiq6516zhzpgciijqyjl1nrji4g7v7l5f";
  };

  buildInputs = [
    curl
    glew
    glfw
    gnome2.gtk.dev
    jansson
    libsamplerate
    libzip
    makeWrapper
    pkgconfig
    rtaudio
    rtmidi
  ];

  # include the plugins
  prePatch = ''
    # todo create a simple loop to do this
    mkdir -p  \
          plugins/AudibleInstruments \
          plugins/Fundamental \
          plugins/Befaco/build \
          plugins/ESeries

    cp -a $pluginFundamental/*        plugins/Fundamental
    cp -a $pluginBefco/*              plugins/Befaco
    cp -a $pluginESeries/*            plugins/ESeries
    cp -a $pluginAudibleInstruments/* plugins/AudibleInstruments
  '';

  patches = [
    # patch to work with xmonad
    # from https://github.com/sorki/Rack/commit/e1a81a44e400c23b5239d941e9cc4943009ea714
    ./window.patch
  ];

  postPatch = ''
    # patch RtAudio include
    sed src/core/AudioInterface.cpp -i -e "s@RtAudio.h@rtaudio/RtAudio.h@"

    # otherwise we will not find the fonts and pulgins
    sed src/asset.cpp -i -e "46s@.*@dir = \"$out/share\"\;@"
    sed src/asset.cpp -i -e "49s@.*@dir = \"$out/share\"\;@"
  '';


  buildPhase = ''
    make allplugins && make
  '';

  installPhase = ''
    mkdir -p $out/{bin,share}
    cp Rack $out/share
    ln -s ../share/Rack $out/bin/Rack
    ln -s ../share/Rack $out/bin/VCVRack

    cp -r res     $out/share/
    cp -r plugins $out/share/ # todo : only copy libs
  '';

  meta = {
    description     = "Open-source virtual modular synthesizer";
    longDescription = ''
      Rack is the engine for the VCV open-source virtual Eurorack DAW.
    '';
    homepage     = https://vcvrack.com/;
    downloadPage = https://vcvrack.com/;
    license      = stdenv.lib.licenses.bsd3;
    maintainers  = [ stdenv.lib.maintainers.mrVanDalo ];
    platforms    = stdenv.lib.platforms.linux;
  } ;
}
