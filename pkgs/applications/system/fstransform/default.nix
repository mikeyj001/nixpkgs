# fstransform.  

{ stdenv, lib, fetchgit, autoPatchelfHook }:
#{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  pname = "fstransform";
  version = "0.9.4";

  src = fetchgit {
  	url = "https://github.com/cosmos72/fstransform.git";
        ref = "master";
  };

#  sourceRoot = ".";

#  dontConfigure = false;
#  dontBuild = false;
#  dontStrip = true;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

#  buildInputs = [  
#		stdenv.cc.cc.lib 
#		myScript
#		  gtk3
#		  xorg.libX11		  
#		  xorg.libxcb
#		  xorg.libXdamage
#		  dbus-glib
#		  xorg.libXt
#  ];

#  configurePhase = ''
#    ./configure 
#  '';

#  buildPhase = ''
#    make
#  '';

#  installPhase = ''
#    mkdir -p $out
#    cp -rv * $out
#    export PATH=$out:$PATH
#  '';

  meta = with lib; {
    homepage = "https://github.com/cosmos72/fstransform";
    longDescription = ''The program 'fstransform' does the following: it takes a device with a filesystem on it (even if almost full) 
    and transforms the device to a different filesystem type, in-place (i.e. without backup) and non-destructively 
    (i.e. it preserves all your data).";
    '';
    license = licenses.free;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "Michael Johnson" ];
  };
}
