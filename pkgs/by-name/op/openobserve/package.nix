{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, protobuf
, bzip2
, oniguruma
, sqlite
, xz
, zlib
, zstd
, stdenv
, darwin
, buildNpmPackage
}:

let
  version = "0.7.2";
  src = fetchFromGitHub {
    owner = "openobserve";
    repo = "openobserve";
    rev = "v${version}";
    hash = "sha256-BFLQL3msDuurRSFOCbqN0vK4NrTS9M6k1hNwet/9mnw=";
{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  fetchurl,
  pkg-config,
  protobuf,
  bzip2,
  oniguruma,
  sqlite,
  xz,
  zlib,
  zstd,
  buildNpmPackage,
  gitUpdater,
}:

let
  version = "0.15.3";
  src = fetchFromGitHub {
    owner = "openobserve";
    repo = "openobserve";
    tag = "v${version}";
    hash = "sha256-rTp+DkADqYkJg1zJog1yURE082V5kCqgid/oUd81SN8=";
    hash = "sha256-+YcVTn/jcEbaqTycMCYn6B0z2HsvgrCY1gHnkRajwSs=";
    hash = "sha256-GHyfIVUSX7evP3LaHZClD1RjZ6somYcMNBFdkaZL7lg=";
  };
  web = buildNpmPackage {
    inherit src version;
    pname = "openobserve-ui";

    sourceRoot = "source/web";

    npmDepsHash = "sha256-eYrspgejb5VR51wAXdGr+pSXDdGnRyX5cwwopK3Kex8=";
    sourceRoot = "${src.name}/web";

    npmDepsHash = "sha256-awfQR1wZBX3ggmD0uJE9Fur4voPydeygrviRijKnBTE=";
    npmDepsHash = "sha256-1MUmAWkeYUEL6WZGq1Jg5W2uKa2xj0oZbGlIbvZWT1E=";
    npmDepsHash = "sha256-5bXEC48m3FbtmLwVYYvEdMV3qWA7KNEKVxkMZ94qEpA=";
rustPlatform.buildRustPackage (
  finalAttrs:
  let
    web = buildNpmPackage {
      inherit (finalAttrs) src version;
      pname = "openobserve-ui";

      sourceRoot = "${finalAttrs.src.name}/web";

      npmDepsHash = "sha256-UNdFqUJI/pdHJjjA5Aebnvq1T7oITJ1R96rEQOBxTug=";

      preBuild = ''
        # Patch vite config to not open the browser to visualize plugin composition
        substituteInPlace vite.config.ts \
          --replace "open: true" "open: false";
      '';

      env = {
        NODE_OPTIONS = "--max-old-space-size=8192";
        # cypress tries to download binaries otherwise
        CYPRESS_INSTALL_BINARY = 0;
      };

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share
        mv dist $out/share/openobserve-ui
        runHook postInstall
      '';
    };
  in
  {
    pname = "openobserve";
    version = "0.50.3";

    src = fetchFromGitHub {
      owner = "openobserve";
      repo = "openobserve";
      tag = "v${finalAttrs.version}";
      hash = "sha256-eL1Qvl6M8idBHXSNHHQsTsu6g/CbTOt8NUTTaNZuB8M=";
    };

    patches = [
      # prevent using git to determine version info during build time
      ./build.rs.patch
    ];

    preBuild = ''
      cp -r ${web}/share/openobserve-ui web/dist
    '';

  # prevent using git to determine version info during build time
  patches = [
  patches = [
    # prevent using git to determine version info during build time
    ./build.rs.patch
  ];

  preBuild = ''
    cp -r ${web}/share/openobserve-ui web/dist
  '';
  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "enrichment-0.1.0" = "sha256-FDPSCBkx+DPeWwTBz9+ORcbbiSBC2a8tJaay9Pxwz4w=";
      "datafusion-33.0.0" = "sha256-RZAgk7up83zxPbmNzdnzB6M0yjjK9MYms+6TpXVDJ1o=";
    };
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-FWMUPghx9CxuzP7jFZYSIwZsylApWzQsfx8DuwS4GTo=";
  cargoHash = "sha256-vfc6B+Uc8RXQD8vGC1yV9w5YAefkYJMpCH2frqjrSWk=";
  cargoHash = "sha256-j/bx4qoWcSh2/yJ9evnzSfyUd0tLAk4M310A89k4wy8=";
    cargoHash = "sha256-d67ZeAth0Q8h8xXJZl+2Z2/+M54Ef4xFlsPT9CnrwK4=";

    nativeBuildInputs = [
      pkg-config
      protobuf
    ];

    buildInputs = [
      bzip2
      oniguruma
      sqlite
      xz
      zlib
      zstd
    ];

    env = {
      RUSTONIG_SYSTEM_LIBONIG = true;
      ZSTD_SYS_USE_PKG_CONFIG = true;

  buildInputs = [
    bzip2
    oniguruma
    sqlite
    xz
    zlib
    zstd
  ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    CoreFoundation
    IOKit
    Security
    SystemConfiguration
  ]);
  ];
      RUSTC_BOOTSTRAP = 1; # uses experimental features

      # the patched build.rs file sets these variables
      GIT_VERSION = finalAttrs.src.tag;
      GIT_COMMIT_HASH = "builtByNix";
      GIT_BUILD_DATE = "1970-01-01T00:00:00Z";

      RUSTFLAGS = "-C target-feature=+aes,+sse2";

    # the patched build.rs file sets these variables
    GIT_VERSION = src.rev;
    GIT_VERSION = src.tag;
    GIT_COMMIT_HASH = "builtByNix";
    GIT_BUILD_DATE = "1970-01-01T00:00:00Z";
  };

  # requires network access or filesystem mutations
  checkFlags = [
    "--skip handler::http::auth::tests::test_validate"
    "--skip handler::http::router::ui::tests::test_index_not_ok"
    "--skip handler::http::router::ui::tests::test_index_ok"
    "--skip handler::http::request::search::saved_view::tests::test_create_view_post"
    "--skip infra::cache::file_list::tests::test_get_file_from_cache"
    "--skip infra::cache::tmpfs::tests::test_delete_prefix"
    "--skip infra::cluster::tests::test_get_node_ip"
    "--skip infra::db::tests::test_delete"
    "--skip service::alerts::test::test_alerts"
    "--skip service::compact::merge::tests::test_compact"
    "--skip service::db::compact::file_list::tests::test_files"
    "--skip service::db::compact::file_list::tests::test_file_list_offset"
    "--skip service::db::compact::file_list::tests::test_file_list_process_offset"
    "--skip service::db::compact::files::tests::test_compact_files"
    "--skip service::db::user::tests::test_user"
    "--skip service::ingestion::grpc::tests::test_get_val"
    "--skip service::organization::tests::test_organization"
    "--skip service::search::sql::tests::test_sql_full"
    "--skip service::triggers::tests::test_triggers"
    "--skip service::users::tests::test_post_user"
    "--skip service::users::tests::test_user"
    "--skip common::infra::cache::file_data::disk::tests::test_get_file_from_cache"
    "--skip common::infra::db::tests::test_get"
    "--skip common::utils::auth::tests::test_is_root_user2"
    "--skip tests::e2e_test"
  ];

  meta = with lib; {
    description = "10x easier, 🚀 140x lower storage cost, 🚀 high performance,  🚀 petabyte scale - Elasticsearch/Splunk/Datadog alternative for 🚀 (logs, metrics, traces";
    homepage = "https://github.com/openobserve/openobserve";
    license = licenses.asl20;
    maintainers = with maintainers; [ happysalada ];
    "--skip=handler::http::router::tests::test_get_proxy_routes"
    "--skip=tests::e2e_test"
    "--skip=tests::test_setup_logs"
    "--skip=handler::http::router::middlewares::compress::Compress"
    # Tests are not threadsafe. Most likely can only run one test at a time,
    # due to altering shared database state.
    # This option already in upstream code: https://github.com/openobserve/openobserve/pull/7084
    # Also see: https://github.com/NixOS/nixpkgs/pull/457421
    "--test-threads=1"
  ];
      SWAGGER_UI_DOWNLOAD_URL =
        # When updating:
        # - Look for the version of `utoipa-swagger-ui` at:
        #   https://github.com/StractOrg/stract/blob/<STRACT-REV>/Cargo.toml#L183
        # - Look at the corresponding version of `swagger-ui` at:
        #   https://github.com/juhaku/utoipa/blob/utoipa-swagger-ui-<UTOPIA-SWAGGER-UI-VERSION>/utoipa-swagger-ui/build.rs#L21-L22
        let
          swaggerUiVersion = "5.17.14";
          swaggerUi = fetchurl {
            url = "https://github.com/swagger-api/swagger-ui/archive/refs/tags/v${swaggerUiVersion}.zip";
            hash = "sha256-SBJE0IEgl7Efuu73n3HZQrFxYX+cn5UU5jrL4T5xzNw=";
          };
        in
        "file://${swaggerUi}";
    };

    # swagger-ui will once more be copied in the target directory during the check phase
    # Not deleting the existing unpacked archive leads to a `PermissionDenied` error
    preCheck = ''
      rm -rf target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/build/
    '';

    # Skip doctests: upstream release build for v0.50.3 runs cargo build only,
    # and the doctest examples currently fail due to async context.
    cargoTestFlags = [
      "--lib"
      "--bins"
      "--tests"
      "--examples"
    ];

    # requires network access or filesystem mutations
    checkFlags = [
      "--skip=handler::http::router::tests::test_get_proxy_routes"
      "--skip=tests::e2e_test"
      "--skip=tests::test_setup_logs"
      "--skip=handler::http::router::middlewares::compress::Compress"
      "--skip=service::github"
      # Tests are not threadsafe. Most likely can only run one test at a time,
      # due to altering shared database state.
      # This option already in upstream code: https://github.com/openobserve/openobserve/pull/7084
      # Also see: https://github.com/NixOS/nixpkgs/pull/457421
      "--test-threads=1"
    ];

    passthru.updateScript = gitUpdater {
      rev-prefix = "v";
      ignoredVersions = "rc";
    };

    meta = {
      description = "Cloud-native observability platform built specifically for logs, metrics, traces, analytics & realtime user-monitoring";
      homepage = "https://github.com/openobserve/openobserve";
      changelog = "https://github.com/openobserve/openobserve/releases/tag/v${finalAttrs.version}";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ happysalada ];
      mainProgram = "openobserve";
    };
  }
)
