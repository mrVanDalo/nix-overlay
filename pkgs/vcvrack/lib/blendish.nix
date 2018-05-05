{ stdenv, fetchFromGitHub, premake4, pkgconfig, glew, glfw, libX11, libXau, libXdmcp, libXrandr, libXext, libXinerama, libXcursor, libpthreadstubs, nanovg }:

stdenv.mkDerivation rec {
  name = "blendish";

  meta = with stdenv.lib; {
    description = "Blendish is a small collection of drawing functions for NanoVG in a single C header file, designed to replicate the look of the Blender 2.5+ User Interface.";
    homepage = https://github.com/AndrewBelt/oui-blendish/;
    # with gpl2 bits from blender and separate bistream vera license
    license = licenses.bsd3;
    maintainers = [ maintainers.sorki ];
    platforms = platforms.all;
  };

  src = fetchFromGitHub {
    owner = "AndrewBelt";
    repo = "oui-blendish";
    rev = "df38de6d065cd93bcbd998aa76bdac063e748573";
    sha256 = "0jvqi9q525mvgzypkjfhgbj8c1jakd42p31xywzfw5yl35wln2ll";
  };

  nativeBuildInputs = [ pkgconfig premake4 ];
  buildInputs = [ glew glfw libX11 nanovg libpthreadstubs libXau libXdmcp libXrandr libXext libXinerama libXcursor ];

  configurePhase = "premake4 --file=premake4.lua gmake";
  makeFlags = "-C build/";

  #buildPhase = "cat build/Makefile";

  patchPhase = ''
    sed -i 's|"nanovg/src/nanovg.c"|"${nanovg}/src/nanovg.c"|g' premake4.lua
    sed -i 's|includedirs { "nanovg/src" }|includedirs { "${nanovg}/src"}|g' premake4.lua

  '';

  installPhase = ''
    ls build/
    ls build/obj/Debug/
    mkdir -p $out/{include,lib}
    cp blendish.h $out/include/
  '';
}
