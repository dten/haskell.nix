inputs: pkgs:

let

  makeZippedTools = { customPkgs, clearStripDebugFlags ? false }: 
    let 
      hsPkgs = (import ./project.nix inputs customPkgs).hsPkgs;
      
      maybeClearStripDebugFlags = drv: 
        if clearStripDebugFlags then 
          drv.overrideDerivation (_: { stripDebugFlags = []; })
        else 
          drv;

      getNixToolsExe = name: hsPkgs.nix-tools.components.exes.${name};
      getStrippedNixToolsExe = name: maybeClearStripDebugFlags (getNixToolsExe name);

      strippedNixToolsComponents = map getStrippedNixToolsExe [
        "cabal-name" 
        "cabal-to-nix" 
        "hackage-to-nix" 
        "hashes-to-nix" 
        "lts-to-nix" 
        "make-install-plan" 
        "plan-to-nix" 
        "stack-repos" 
        "stack-to-nix" 
        "truncate-index" 
      ];
    in 
      customPkgs.packaging.asZip {
        name = "${customPkgs.hostPlatform.system}-nix-tools-static";
        drvs' = [ 
          hsPkgs.cabal-install.components.exes.cabal 
          hsPkgs.hpack.components.exes.hpack 
        ] ++ strippedNixToolsComponents;
      };

  
  zippedToolsNoIfdFor = fragment-name: 
    let 
      stringifyInputs = inputs: map (x: "${x}") (builtins.attrValues inputs);
    in
      pkgs.runCommand "${pkgs.hostPlatform.system}-all-nix-tools" {
        requiredSystemFeatures = [ "recursive-nix" ];
        nativeBuildInputs = 
          [ pkgs.nix pkgs.gitMinimal ]
          ++ stringifyInputs inputs
          ++ stringifyInputs inputs.haskellNix.inputs;
          # ++ stringifyInputs inputs.iohkNix.inputs;
      } ''
        export HOME=$(mktemp -d)
        mkdir $out
        cp $(nix --offline --extra-experimental-features "flakes nix-command" \
          build --accept-flake-config --no-link --print-out-paths \
          --system ${pkgs.hostPlatform.system} \
          ${../.}#${fragment-name})/*.zip $out/
      '';


  zippedToolsForDarwin = makeZippedTools {
    customPkgs = pkgs;
    clearStripDebugFlags = true;
  };


  zippedToolsForLinux = makeZippedTools {
    customPkgs = pkgs.pkgsCross.musl64;
  };


  zippedToolsForLinuxArm64 = makeZippedTools {
    customPkgs = pkgs.pkgsCross.aarch64-multiplatform-musl;
  };


  allZippedTools = 
    pkgs.lib.optionalAttrs (pkgs.system == "x86_64-darwin" || pkgs.system == "aarch64-darwin") { 
      "nix-tools-static" = zippedToolsForDarwin;
      "nix-tools-static-no-ifd" = zippedToolsNoIfdFor "nix-tools-static";
    } 
    // 
    pkgs.lib.optionalAttrs (pkgs.system == "x86_64-linux") {
      "nix-tools-static" = zippedToolsForLinux;
      "nix-tools-static-arm64" = zippedToolsForLinuxArm64;

      "nix-tools-static-no-ifd" = zippedToolsNoIfdFor "nix-tools-static";
      "nix-tools-static-arm64-no-ifd" = zippedToolsNoIfdFor "nix-tools-static-arm64";
    };

in


allZippedTools

 