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

      meta = {
        changelog = "https://github.com/jetty/jetty.project/releases/tag/jetty-${version}";
        description = "Web server and javax.servlet container";
        homepage = "https://jetty.org/";
        platforms = lib.platforms.all;
        sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
        license = with lib.licenses; [
          asl20
          epl10
        ];
        maintainers = with lib.maintainers; [
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
    version = "12.1.1";
    hash = "sha256-VHmPhVEqq4eoOwo9O7sbdv6bJB9dCFkN+64jTlnFarM=";
    version = "12.1.2";
    hash = "sha256-GtaEIXqOSutgrSJJ/+oFuGSe7y8omVX7sBgcG3GJzvs=";
    version = "12.1.3";
    hash = "sha256-+DCfP0tFBouTZqOEzCFaQ4dl78xPFudUzS9hAzUkc7Y=";
=======
    version = "12.1.5";
    hash = "sha256-tjZO7OtQ7FZQAGA9lI4YIKwm+ZW0eJgGTaNd+ZasDY4=";
>>>>>>> 30154124f004884b3846d043eef0f6770c41332d
  };
}
