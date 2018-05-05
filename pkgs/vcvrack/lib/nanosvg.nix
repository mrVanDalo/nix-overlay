{ stdenv, fetchFromGitHub, premake4, pkgconfig, glew, glfw, libX11, libXau, libXdmcp, libXrandr, libXext, libXinerama, libXcursor, libpthreadstubs }:

stdenv.mkDerivation rec {
  name = "nanosvg";

  meta = with stdenv.lib; {
    description = "Simple stupid SVG parser ";
    homepage = https://github.com/memononen/nanosvg;
    license = licenses.zlib;
    maintainers = [ maintainers.sorki ];
    platforms = platforms.all;
  };

  src = fetchFromGitHub {
    owner = "memononen";
    repo = "nanosvg";
    rev = "9a74da4db5ac74083e444010d75114658581b9c7";
    sha256 = "1bfgjga886bn52g447ihid7b0d9wz17623f6gi6fsd8gzyg0k1c8";
  };

  nativeBuildInputs = [ pkgconfig premake4 ];
  buildInputs = [ glew glfw libX11 libpthreadstubs libXau libXdmcp libXrandr libXext libXinerama libXcursor ];

  configurePhase = "premake4 gmake";
  makeFlags = "-C build/";

  installPhase = ''
    ls -R build/
    mkdir -p $out/src
    cp src/* $out/src/
    #cp build/libnanosvg.a $out/lib/
  '';
}
