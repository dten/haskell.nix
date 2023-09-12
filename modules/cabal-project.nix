{ lib, config, pkgs, ... }:
with lib;
with types;
{
  _file = "haskell.nix/modules/cabal-project.nix";

  imports = [
    ./cabal-project/ghcjs-overlay.nix
    ./cabal-project/head-hackage.nix
    ./cabal-project/read-src-project-config.nix
    ./cabal-project/repositories.nix
  ];

  options = {
    # Used by callCabalProjectToNix
    compiler-nix-name = mkOption {
      type = str;
      description = "The name of the ghc compiler to use eg. \"ghc884\"";
      # Map short version names to the latest GHC version.
      # TODO: perhaps combine this with the `latestVer` mapping in `overlays/boostrap.nix`.
      apply = name:
        let
          shortNameMap = {
            ghc810 = "ghc8107";
            ghc90 = "ghc902";
            ghc92 = "ghc928";
            ghc94 = "ghc947";
            ghc96 = "ghc962";
            ghc980 = "ghc980${__substring 0 8 pkgs.haskell-nix.sources.ghc980.lastModifiedDate}";
            ghc99 = "ghc99${__substring 0 8 pkgs.haskell-nix.sources.ghc99.lastModifiedDate}";
          };
          fullName = shortNameMap.${name} or name;
        in
          # cabal-install from hackage (3.10.1.0) does not build with GHC HEAD
          if fullName == shortNameMap.ghc99 && config.name == "cabal-install" && config.version == "3.10.1.0"
            then "ghc962"
            else fullName;
    };
    compilerSelection = mkOption {
      type = unspecified;
      default = p: p.haskell-nix.compiler;
      description = "Use GHC from pkgs.haskell instead of pkgs.haskell-nix";
    };
    index-state = mkOption {
      type = nullOr str;
      default = null;
      description = "Hackage index-state, eg. \"2019-10-10T00:00:00Z\"";
    };
    index-sha256 = mkOption {
      type = nullOr str;
      default = null;
      description = "The hash of the truncated hackage index-state";
    };
    plan-sha256 = mkOption {
      type = nullOr str;
      default = null;
      description = "The hash of the plan-to-nix output (makes the plan-to-nix step a fixed output derivation)";
    };
    materialized = mkOption {
      type = nullOr (either path package);
      default = null;
      description = "Location of a materialized copy of the nix files";
    };
    checkMaterialization = mkOption {
      type = nullOr bool;
      default = null;
      description = "If true the nix files will be generated used to check plan-sha256 and material";
    };
    cabalProjectFileName = mkOption {
      type = str;
      default = "cabal.project";
    };
    cabalProject = mkOption {
      type = nullOr lines;
      default = null;
    };
    cabalProjectLocal = mkOption {
      type = nullOr lines;
      default = null;
    };
    cabalProjectFreeze = mkOption {
      type = nullOr lines;
      default = null;
    };
    ghc = mkOption {
      type = nullOr package;
      default = null;
      description = "Deprecated in favour of `compiler-nix-name`";
    };
    ghcOverride = mkOption {
      type = nullOr package;
      default = null;
      description = "Used when we need to set ghc explicitly during bootstrapping";
    };
    # The defaults for `nix-tools` and `cabal-install` are in `call-cabal-project-to-nix.nix`
    # to make sure it is not evaluated too strictly (which would lead to infinite recursion).
    nix-tools = mkOption {
      type = nullOr package;
      default = null;
      description = "nix-tools to use when converting the `plan.json` to nix";
    };
    configureArgs = mkOption {
      type = nullOr (separatedString " ");
      default = "";
      description = ''
        Extra arguments to pass to `cabal v2-configure`.
        `--enable-tests --enable-benchmarks` are included by default.
        If the tests and benchmarks are not needed and they
        cause the wrong plan to be chosen, then we can use
        `configureArgs = "--disable-tests --disable-benchmarks";`
      '';
    };
    sha256map = mkOption {
      type = nullOr (attrsOf (either str (attrsOf str)));
      # Default needed for haskell-language-server 1.10
      default."https://github.com/pepeiborra/ekg-json"."7a0af7a8fd38045fd15fb13445bdcc7085325460" = "sha256-fVwKxGgM0S4Kv/4egVAAiAjV7QB5PBqMVMCfsv7otIQ=";
      description = ''
        An alternative to adding `--sha256` comments into the
        cabal.project file:
          sha256map =
            { "https://github.com/jgm/pandoc-citeproc"."0.17"
              = "0dxx8cp2xndpw3jwiawch2dkrkp15mil7pyx7dvd810pwc22pm2q"; };
      '';
    };
    inputMap = mkOption {
      type = nullOr attrs;
      default = {};
      description = ''
        Specifies the contents of urls in the cabal.project file.
        The `.rev` attribute is checked against the `tag` for `source-repository-packages`.
        # FIXME is the following still relevant?
        For `revision` blocks the `inputMap.<url>` will be used and
        they `.tar.gz` for the `packages` used will also be looked up
        in the `inputMap`.
      '';
    };
    extra-hackage-tarballs = mkOption {
      type = nullOr attrs;
      default = {};
    };
    source-repo-override = mkOption {
      type = attrsOf (functionTo attrs);
      default = {};
    };
    supportHpack = mkOption {
      type = bool;
      default = false;
    };

    # Used by mkCabalProjectPkgSet
    pkg-def-extras = mkOption {
      type = nullOr (listOf unspecified);
      default = [];
    };
    modules = mkOption {
      type = nullOr (listOf unspecified);
      default = [];
    };
    extra-hackages = mkOption {
      type = nullOr (listOf unspecified);
      default = [];
    };
  };
}
