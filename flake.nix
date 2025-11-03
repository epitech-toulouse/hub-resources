{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    press = {
      url = "github:RossSmyth/press";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    press,
  }: let
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        overlays = [
          (import press)
        ];
      };

    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "aarch64-linux"
      ] (system: function (pkgsFor system));

    localPackages = forAllSystems (
      pkgs: let
        lib = pkgs.lib;
        allFiles = builtins.filter (f: (builtins.baseNameOf f) == "default.nix") (lib.filesystem.listFilesRecursive ./.);

        dirPaths = map (f: builtins.dirOf (toString f)) allFiles;

        allPackages =
          map (
            f: {
              name = builtins.baseNameOf (builtins.dirOf (toString f));
              value = pkgs.callPackage f {};
            }
          )
          allFiles;
        allDerivations = lib.listToAttrs allPackages;

        packagesInput =
          pkgs.linkFarm "local-packages-input"
          (lib.attrsets.mapAttrsToList (name: value: {
              name = name;
              path = value;
            })
            allDerivations);

        structuredResult =
          pkgs.runCommand "structured-packages-output" {
            packagesDir = packagesInput;
          } ''
            mkdir -p $out
            for pkgName in $(ls $packagesDir); do
              pkgPath="$packagesDir/$pkgName"
              ln -s "$pkgPath" "$out/$pkgName"
            done
          '';
      in {
        packages =
          allDerivations
          // rec {
            all = structuredResult;
            default = all;
          };
      }
    );
    allDerivations = nixpkgs.lib.attrValues (nixpkgs.lib.filterAttrs (n: v: nixpkgs.lib.isDerivation v) (nixpkgs.lib.flatten localPackages));
  in rec {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    checks = forAllSystems (pkgs: let
      inherit (pkgs) lib system;

      hooks = {
        alejandra.enable = true;
        check-merge-conflicts.enable = true;
        check-shebang-scripts-are-executable.enable = true;
        check-added-large-files.enable = true;
      };
    in {
      pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
        inherit hooks;
        src = ./.;
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;

        name = "hub-resources";
        packages = with pkgs; [
          alejandra
          typst
          jetbrains-mono
        ];
      };
    });

    packages = forAllSystems (
      pkgs:
        localPackages.${pkgs.system}.packages
    );
  };
}
