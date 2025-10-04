<<<<<<< HEAD
{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "jetty";
  version = "12.0.2";
  src = fetchurl {
    url = "mirror://maven/org/eclipse/jetty/jetty-home/${version}/jetty-home-${version}.tar.gz";
    hash = "sha256-DtlHTXjbr31RmK6ycDdiWOL7jIpbWNh0la90OnOhzvM=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    mv etc lib modules start.jar $out
  '';

  meta = with lib; {
    description = "A Web server and javax.servlet container";
    homepage = "https://www.eclipse.org/jetty/";
    platforms = platforms.all;
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = with licenses; [ asl20 epl10 ];
    maintainers = with maintainers; [ emmanuelrosa ];
=======
{
  lib,
  stdenvNoCC,
  fetchurl,
  gitUpdater,
}:

let
  common =
    { version, hash }:
    stdenvNoCC.mkDerivation rec {
      pname = "jetty";

      inherit version;

      src = fetchurl {
        url = "mirror://maven/org/eclipse/jetty/jetty-home/${version}/jetty-home-${version}.tar.gz";
        inherit hash;
      };

      dontBuild = true;

      installPhase = ''
        mkdir -p $out
        mv etc lib modules start.jar $out
      '';

      passthru.updateScript = gitUpdater {
        url = "https://github.com/jetty/jetty.project.git";
        allowedVersions = "^${lib.versions.major version}\\.";
        ignoredVersions = "(alpha|beta).*";
        rev-prefix = "jetty-";
      };

      meta = with lib; {
        changelog = "https://github.com/jetty/jetty.project/releases/tag/jetty-${version}";
        description = "Web server and javax.servlet container";
        homepage = "https://jetty.org/";
        platforms = platforms.all;
        sourceProvenance = with sourceTypes; [ binaryBytecode ];
        license = with licenses; [
          asl20
          epl10
        ];
        maintainers = with maintainers; [
          emmanuelrosa
          anthonyroussel
        ];
      };
    };

in
{
  jetty_11 = common {
    version = "11.0.26";
    hash = "sha256-uJgh/+/uGjchTgtoF38f7jIvbdrwdToAsqqVOlYtMIM=";
  };

  jetty_12 = common {
<<<<<<< HEAD
    version = "12.0.21";
    hash = "sha256-U/W6h0S7b0zLoYahDGo/pkKa+NIMKR0tiX3pyRl40zg=";
>>>>>>> 21f764487f63dff0f5b1dfcdecfecf9e96c13e4a
=======
    version = "12.1.1";
    hash = "sha256-VHmPhVEqq4eoOwo9O7sbdv6bJB9dCFkN+64jTlnFarM=";
>>>>>>> 95e041bd9cbfa4d8a4efb322b9111779f2c64465
  };
}
