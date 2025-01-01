<<<<<<< HEAD
{ callPackage, ... } @ args:

callPackage ./generic.nix (args // {
  version = "8.0.35-30";
  hash = "sha256-yagqBKU057Gk5pEyT2R3c5DtxNG/+TSPenFgbxUiHPo=";

  # includes https://github.com/Percona-Lab/libkmip.git
  fetchSubmodules = true;

  extraPatches = [
    ./abi-check.patch
  ];

  extraPostInstall = ''
    rm -r "$out"/docs
  '';
})
=======
{ callPackage, ... }@args:

callPackage ./generic.nix (
  args
  // {
    version = "8.0.35-31";
    hash = "sha256-KHfgSi9bQlqsi5aDRBlSpdZgMfOrAwHK51k8KhQ9Udg=";

    # includes https://github.com/Percona-Lab/libkmip.git
    fetchSubmodules = true;

    extraPatches = [
      ./abi-check.patch
    ];

    extraPostInstall = ''
      rm -r "$out"/docs
    '';
  }
)
>>>>>>> 831eb3618dd71835c60e2b7b72f1978cd7c32f60
