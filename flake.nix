{
  description = "Derrick's Nix Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    #home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # hardware.url = "github:nixos/nixos-hardware";
    hardware.url = "github:nixos/nixos-hardware";

    # modern window compositor
    #hyprland.url = "github:hyprwm/Hyprland/v0.31.0";
    hyprland.url = "github:hyprwm/Hyprland";
    # community wayland nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim
    nixvim-flake.url = "github:dweis/nixvim";

    # color scheme - catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    hyprland,
    nixpkgs-wayland,
    nixpkgs-unstable,
    nix-darwin,
    nixos-generators,
    catppuccin-hyprland,
    nixvim-flake,
    ...
  } @ inputs: let
    username = "derrick";
    userghname = "dweis";
    userfullname = "Derrick Weis";
    useremail = "derrick@derrickweis.com";
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    x64_system = "x86_64-linux";
    aarch64_darwin_system = "aarch64-darwin";
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    nixosSystem = import ./lib/nixosSystem.nix;
    macosSystem = import ./lib/macosSystem.nix;

    monoid_modules = {
      nixos-modules = [
        ./hosts/monoid
      ];
      home-module = import ./home/desktop-hyprland.nix;
    };
    lambda_modules = {
      nixos-modules = [
        ./hosts/lambda
      ];
      home-module = import ./home/server.nix;
    };
    x64_specialArgs =
      {
        inherit username userfullname useremail userghname;
        pkgs-unstable = import nixpkgs-unstable {
          system = x64_system;
          config.allowUnfree = true;
        };
      }
      // inputs;
  in {
    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = let
      base_args = {
        inherit home-manager nixos-generators;
        nixpkgs = nixpkgs;
        system = x64_system;
        specialArgs = x64_specialArgs;
      };
    in {
      monoid = nixosSystem (monoid_modules // base_args);
      lambda = nixosSystem (lambda_modules // base_args);
    };

    darwinConfigurations = let
      system = aarch64_darwin_system;
      specialArgs =
        {
          inherit username userfullname useremail userghname;
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        }
        // inputs;
      base_args = {
        inherit nix-darwin home-manager system specialArgs nixpkgs;
      };
      vector_modules = {
        darwin-modules = [hosts/vector];
        home-module = import ./home/desktop-macos.nix;
      };
    in {
      vector = macosSystem (vector_modules // base_args);
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
