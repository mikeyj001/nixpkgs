<<<<<<< HEAD
{ lib
, buildGoModule
, fetchFromGitHub
, stdenv
, Cocoa
, fetchpatch
}:

buildGoModule rec {
  pname = "butler";
  version = "15.21.0";

  src = fetchFromGitHub {
    owner = "itchio";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-vciSmXR3wI3KcnC+Uz36AgI/WUfztA05MJv1InuOjJM=";
  };

  buildInputs = lib.optionals stdenv.isDarwin [
    Cocoa
  ];

  patches = [
    # update x/sys dependency for darwin build https://github.com/itchio/butler/pull/245
    (fetchpatch {
      url = "https://github.com/itchio/butler/pull/245/commits/ef651d373e3061fda9692dd44ae0f7ce215e9655.patch";
      hash = "sha256-rZZn/OGiv3mRyy89uORyJ99zWN21kZCCQAlFvSKxlPU=";
    })
  ];

  proxyVendor = true;

  vendorHash = "sha256-GvUUCQ2BPW0HlXZljBWJ2Wyys9OEIM55dEWAa6J19Zg=";

  doCheck = false;

  meta = with lib; {
    # butler cannot be build with Go >=1.21
    # See https://github.com/itchio/butler/issues/256
    # and https://github.com/itchio/dmcunrar-go/issues/1
    # The dependency causing the issue is marked as 'no maintainence intended'.
    # Last butler release is from 05/2021.
    broken = true;
    description = "Command-line itch.io helper";
    homepage = "https://github.com/itchio/butler";
    license = licenses.mit;
    maintainers = with maintainers; [ martfont ];
{
  buildGoModule,
  brotli,
  lib,
  fetchFromGitHub,
}:

# update instructions:
# - Check if butler version bug was fixed https://github.com/itchio/butler/issues/266
# - if it's fixed, remove patch.
# - if it was not fixed, follow steps below to regenerate the patch
# - manually clone butler, change go.mod's version number to 1.18 at least
# - run `go mod tidy` in the cloned repository.
# - generate patch with `git diff > go.mod.patch`

buildGoModule rec {
  pname = "butler";
  version = "15.24.0";

  src = fetchFromGitHub {
    owner = "itchio";
    repo = "butler";
    tag = "v${version}";
    hash = "sha256-Gzf+8icPIXrNc8Vk8z0COPv/QA6GL6nSvQg13bAlfZM=";
  };

  buildInputs = [ brotli ];

  patches = [ ./go.mod.patch ];

  doCheck = false; # disabled because the tests don't work in a non-FHS compliant environment.

  vendorHash = "sha256-A6u7bKI7eoptkjBuXoQlLYHkEVtrl8aNnBb65k1bFno=";

  # Needed due to vendored dependencies breaking in gnu23 mode.
  env.NIX_CFLAGS_COMPILE = "-std=gnu17";

  meta = {
    description = "Command-line itch.io helper";
    changelog = "https://github.com/itchio/butler/releases/tag/v${version}/CHANGELOG.md";
    homepage = "http://itch.io";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ naelstrof ];
  };
}
