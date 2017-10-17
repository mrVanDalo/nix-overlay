with import <nixpkgs> {}; 

{ ack , tree, ... }:

stdenv.mkDerivation rec {

  name = "memo-${version}";

  version = "0.2";

  src = fetchurl {
    url = "https://github.com/mrVanDalo/memo/archive/${version}.tar.gz";
    sha256 = "0dgxij0k8v4hpfsnpnybbsia88gzd2jxsmbx1z221bvj7v7831k8" ;
  };

  
  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/{bin,share/man/man1,share/bash-completion/completions}
    mv ${name}/memo $out/bin/
    mv ${name}/doc/memo.1 $out/share/man/man1/memo.1
    mv ${name}/completion/memo.bash $out/share/bash-completion/completions/memo.sh
    gzip -9nf $out/share/man/man1/memo.1
  '';
}
