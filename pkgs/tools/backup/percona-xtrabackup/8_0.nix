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
    version = "8.0.35-32";
    hash = "sha256-aNnAlhhzZ6636dzOz4FFDEE4Mb450HGU42cJrM21GdQ=";

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
