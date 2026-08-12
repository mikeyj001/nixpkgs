with import <nixpkgs>{};

{ stdenv, lib, bzip2, glib, dbus-glib, xorg, gtk3, gcc-unwrapped,libXdamage, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  version = "2.53.23";
  name = "seamonkey-${version}";

  src = fetchurl {
#	url = "https:/7/archive.mozilla.org/pub/seamonkey/releases/${version}/linux-x86_64/en-GB/seamonkey-${version}.en-GB.linux-x86_64.tar.bz2";
	url = "https://archive.seamonkey-project.org/releases/${version}/linux-x86_64/en-GB/seamonkey-${version}.en-GB.linux-x86_64.tar.bz2";

	# 2.53.23
#	sha256 = "";
   	sha256 = "sha256-kwh58v+fpyMO0nrDBDv4MPAtokKiHGx8NPdTfSY37YA=";
  };

  unpacked = ''
	bunzip2 $src
	tar xfz seamonkey-${version}.en-GB.linux-x86_64.tar 
   '';

  dontConfigure = true;
  dontBuild = true;
   
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3               # libgtk-3.so.0
    xorg.libxcb        # libX11-xcb.so.1
    stdenv.cc.cc.lib   # libstdc++.so.6
    xorg.libXdamage    # libXdamage.so.1
    dbus-glib          # libdbus-glib-1.so.2
    xorg.libXt         # libXt.so.6
    glib               # libgthread-2.0.so.0
 ];



  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/.local/share/Seamonkey
#    mkdir -p $out
#    cp -av seamonkey $out/bin
    cp -av * $out/bin
    cp $out/bin/chrome/icons/default/default48.png  $out/.local/share/Seamonkey/default48.png
#    'InstallDesktopFile seamonkey.desktop'
  '';

#  preFixup = let
#    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
#    libPath = lib.makeLibraryPath [ 
#   [   gtk3               # libgtk-3.so.0
#       xorg.libxcb        # libX11-xcb.so.1
#       stdenv.cc.cc.lib   # libstdc++.so.6
#       xorg.libXdamage    # libXdamage.so.1
#       dbus-glib          # libdbus-glib-1.so.2
#       xorg.libXt         # libXt.so.6
#       glib               # libgthread-2.0.so.0
#    ]
#    [
#        "/nix/store" 
#    ];
#  ]

#  in ''
#    patchelf \
#      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
#      --set-rpath "${libPath}" \
#      $out/bin/seamonkey
#  '';
  
  autopatchelf = [ "libgtk-3.so.0" ];
 
  dontStrip = true;

  meta = with lib; {
    homepage = "https://www.seamonkey-project.org/";
    description = "Web-browser, advanced e-mail, newsgroup and feed client, IRC chat, and HTML editing.";
    license = licenses.free;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "Michael Johnson" ];
  };
}
