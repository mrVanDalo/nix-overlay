{ stdenv, lib, fetchFromGitHub, cmake
  , libGL, libXrandr, libXinerama, libXcursor, libX11
  , darwin, fixDarwinDylibNames, xlibs
}:

stdenv.mkDerivation rec {
  version = "3.2.1";
  name = "glfw-${version}";

  src = fetchFromGitHub {
    owner = "glfw";
    repo = "GLFW";
    rev = "master";
    sha256 = "0vrad83l9zq6vlh851grcr1mm2mk0h7j531cz581j9jw5zz11hcj";
  };

  enableParallelBuilding = true;

  propagatedBuildInputs = [ libGL ];

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    libX11 libXrandr libXinerama libXcursor xlibs.libXi.dev xlibs.libXext.dev
  ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [ Cocoa Kernel fixDarwinDylibNames ]);

  cmakeFlags = [ "-DBUILD_SHARED_LIBS=ON" ];

  meta = with stdenv.lib; {
    description = "Multi-platform library for creating OpenGL contexts and managing input, including keyboard, mouse, joystick and time";
    homepage = http://www.glfw.org/;
    license = licenses.zlib;
    maintainers = with maintainers; [ marcweber ];
    platforms = platforms.unix;
  };
}
