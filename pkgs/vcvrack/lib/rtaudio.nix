{ stdenv, fetchFromGitHub, libtool, libjack2,  alsaLib, rtmidi, cmake, libpulseaudio }:

stdenv.mkDerivation rec {
  version = "master";
  name = "rtaudio-${version}";

  src = fetchFromGitHub {
    owner  = "thestk";
    repo   = "rtaudio";
    rev    = "ce13dfbf30fd1ab4e7f7eff8886a80f144c75e5d";
    sha256 = "0d5yldqsvmix7s0f3skkh63wb0cxqlpbrysas4qy7rg4i1746dxz";
  };

  buildInputs = [ libtool libpulseaudio libjack2 alsaLib rtmidi cmake];

  cmakeFlags = [
    "-DAUDIO_UNIX_JACK=ON"
    "-DAUDIO_LINUX_ALSA=ON"
    "-DAUDIO_LINUX_PULSE=ON"
  ];

  meta = {
    description = "A set of C++ classes that provide a cross platform API for realtime audio input/output";
    homepage =  http://www.music.mcgill.ca/~gary/rtaudio/;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.magnetophon ];
    platforms = with stdenv.lib.platforms; linux ++ darwin;
  };
}
