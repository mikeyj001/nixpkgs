with import <nixpkgs>{};

{ stdenv, lib, bzip2, glib, dbus-glib, xorg, gtk3, gcc-unwrapped, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  version = "2.53.17.1";
  name = "seamonkey-${version}";

  src = fetchurl {
	url = "https://archive.mozilla.org/pub/seamonkey/releases/${version}/linux-x86_64/en-GB/seamonkey-${version}.en-GB.linux-x86_64.tar.bz2";
	sha256 = "sha256-JGI6objGvH7gwBAqBm1XRtVLfW7MynhpecxKm61yCbQ=";
#	sha256 = "";
	#2.53.17
#	sha256 = "sha256-SZFcMbuWb6O7lggc1ZRPcdbM1Ca2MIE2PbZjtaijvH8=";
  };

  unpacked = ''
	bunzip2 $src
	tar xfz seamonkey-${version}.en-GB.linux-x86_64.tar 
   '';

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -av seamonkey $out/bin
  '';
  preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
    libPath = lib.makeLibraryPath [
      gtk3               # libgtk-3.so.0
      xorg.libxcb        # libX11-xcb.so.1
      stdenv.cc.cc.lib   # libstdc++.so.6
      xorg.libXdamage    # libXdamage.so.1
      dbus-glib          # libdbus-glib-1.so.2
      xorg.libXt         # libXt.so.6
      glib               # libgthread-2.0.so.0
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/seamonkey
  '';

  meta = with lib; {
    homepage = "https://www.seamonkey-project.org/";
    description = "Web-browser, advanced e-mail, newsgroup and feed client, IRC chat, and HTML editing.";
    license = licenses.free;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "Michael Johnson" ];
  };
}
