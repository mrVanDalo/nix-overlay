{ stdenv, fetchFromGitHub, autoconf, automake, libtool, libjack2, alsaLib, pkgconfig }:

stdenv.mkDerivation rec {
  version = "3.0.0";
  name = "rtmidi-${version}";

  src = fetchFromGitHub {
    owner = "thestk";
    repo = "rtmidi";
    rev = "v${version}";
    sha256 = "1z4sj85vvnmvg4pjjs963ghi69srb63jp5xpck46dcb9wgypdviy";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ autoconf automake libtool libjack2 alsaLib ];

  preConfigure = ''
    ./autogen.sh --no-configure
    ./configure
  '';

  meta = {
    description = "A set of C++ classes that provide a cross platform API for realtime MIDI input/output";
    homepage =  http://www.music.mcgill.ca/~gary/rtmidi/;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.magnetophon ];
    platforms = with stdenv.lib.platforms; linux ++ darwin;
  };
}
