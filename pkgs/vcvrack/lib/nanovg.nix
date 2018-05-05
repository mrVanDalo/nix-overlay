{ stdenv, fetchFromGitHub, premake4, pkgconfig, glew, glfw3 }:

stdenv.mkDerivation rec {
  name = "nanovg";

  meta = with stdenv.lib; {
    description = "NanoVG is small antialiased vector graphics rendering library for OpenGL. ";
    homepage    = https://github.com/memononen/nanovg;
    license     = licenses.zlib;
    maintainers = [ maintainers.sorki ];
    platforms   = platforms.all;
  };

  src = fetchFromGitHub {
    owner  = "memononen";
    repo   = "nanovg";
    rev    = "364911b596bb691e4b2f59f15df7763772ebe2bb";
    sha256 = "1bzyqcaa0gdsd0y0kzj9i1n2z2n1cnfcf05f1k477r4k547ra48p";
  };

  nativeBuildInputs = [ pkgconfig premake4 ];
  buildInputs = [ glew glfw3 ];

  configurePhase = "premake4 gmake";
  makeFlags = "-C build/";

  installPhase = ''
    mkdir -p $out/{src,lib}
    cp src/* $out/src/
    cp build/libnanovg.a $out/lib/
  '';
}
