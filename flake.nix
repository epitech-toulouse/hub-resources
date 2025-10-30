{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "aarch64-linux"
      ] (system: function nixpkgs.legacyPackages.${system});
  in {
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
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        inherit hooks;
        src = ./.;
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;

        name = "hub-resources";
        packages = with pkgs; [
          typst
        ];
      };
    });
  };
}
