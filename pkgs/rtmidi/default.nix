{ stdenv, fetchFromGitHub, rtmidi }:

rtmidi.overrideAttrs ( oldAttrs : rec {

  version = "3.0.0";

  name = "rtmidi-${version}";

  src = fetchFromGitHub {
    owner = "thestk";
    repo = "rtmidi";
    rev = "v${version}";
    sha256 = "1z4sj85vvnmvg4pjjs963ghi69srb63jp5xpck46dcb9wgypdviy";
  };

})
