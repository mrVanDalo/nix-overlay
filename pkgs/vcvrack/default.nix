{ stdenv, fetchFromGitHub, fetchgit, makeWrapper, gcc, fetchpatch,
  curl,  gnome2, jansson, libsamplerate, libzip, pkgconfig,
  glew, glfw, rtaudio, rtmidi, alsaLib, speexdsp, blendish, nanosvg, nanovg, osdialog,
  ... }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name    = "vcvrack-${version}";
  version = "0.6.0";

  # need to use fetchgit here to pull submodules as well
  src = fetchgit {
    url    = "https://github.com/VCVRack/Rack.git";
    rev    = "v${version}";
    sha256 = "1c6wv5w5ldv3xw96zh829mkpn15asd17r73ilafl61y0h5rbnqb1";
  };

  patches = [ ./xmonad.patch ] ;

  postPatch = ''
    # otherwise we will not find the fonts
    sed src/asset.cpp -i -e "45s@.*@dir = \"$out/share/vcvrack\"\;@"
    sed src/asset.cpp -i -e "48s@.*@dir = \"$out/share/vcvrack\"\;@"
  '';

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

    alsaLib
    speexdsp
    blendish
    nanosvg
    nanovg
    osdialog
  ];

  buildPhase = ''
    local CFLAGS
    CFLAGS=$(pkg-config --cflags glew jansson libcurl libzip openssl rtmidi speexdsp )

    local FLAGS
    FLAGS="-I${nanovg}/src -I${nanosvg}/src -I${rtaudio}/include/rtaudio -I${osdialog}/src"

    sed -i '/\t$(MAKE) -C dep/d' Makefile
    CFLAGS="$CFLAGS" FLAGS="$FLAGS" make RELEASE=1
  '';

  installPhase = ''
    mkdir -p      $out/{bin,share/vcvrack}

    cp Rack       $out/share/vcvrack
    cp -r res     $out/share/vcvrack/

    ln -s         $out/share/vcvrack/Rack $out/bin/Rack
    ln -s         $out/share/vcvrack/Rack $out/bin/VCVRack
  '';

  meta = with stdenv.lib; {
    homepage        = https://vcvrack.com/;
    license         = with licenses; [ bsd3 mit ];
    maintainers     = [ maintainers.mrVanDalo ];
    platforms       = platforms.linux;
    description     = "Open-source virtual modular synthesizer";
    longDescription = ''
      Rack is the engine for the VCV open-source virtual Eurorack DAW.
    '';
  } ;
}
