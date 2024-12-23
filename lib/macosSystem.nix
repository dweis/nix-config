{
  nixpkgs,
  nix-darwin,
  home-manager,
  system,
  specialArgs,
  darwin-modules,
  home-module,
}: let
  username = specialArgs.username;
in
  nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules =
      darwin-modules
      ++ [
        {
          # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
          nix.registry.nixpkgs.flake = nixpkgs;

          # avoiding conflict https://github.com/LnL7/nix-darwin/issues/1082#issuecomment-2358489238
          nixpkgs.flake = {
            setFlakeRegistry = false;
            setNixPath = false;
          };


          # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
          environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
          nix.nixPath = ["/etc/nix/inputs"];
        }

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${username}" = home-module;
          home-manager.backupFileExtension = ".nix-back";
        }
      ];
  }
