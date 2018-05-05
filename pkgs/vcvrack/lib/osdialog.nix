{ stdenv, fetchFromGitHub, pkgconfig, gtk2 }:

stdenv.mkDerivation rec {
  name = "osdialog";

  meta = with stdenv.lib; {
    description = " A cross platform wrapper for OS dialogs like file save, open, message boxes, inputs, color picking, etc.";
    homepage = https://github.com/AndrewBelt/osdialog;
    license = licenses.cc0;
    maintainers = [ maintainers.sorki ];
    platforms = platforms.all;
  };

  src = fetchFromGitHub {
    owner = "AndrewBelt";
    repo = "osdialog";
    rev = "015d020615e8169d2f227ad385c5f2aa1e091fd1";
    sha256 = "0vs4h4ynmah65ma5cxpkvdy0fips0cmha4gqqqam3h528f6p25hx";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ gtk2 ];

  makeFlags = "ARCH=gtk2";

  installPhase = ''
    mkdir -p $out/src/
    cp *.{c,h} $out/src/
  '';
}
