{
  description = "Danil Suetin NixOS configuration. Code name: Vidar.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      # Custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

      # Nix formatter
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;

      # Packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS modules you might want to export
      nixosModules = import ./modules;

      nixosConfigurations.vidar = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs outputs; };
        modules = [
          ({ lib, ... }: {
            imports = [
              inputs.home-manager.nixosModules.home-manager
            ] ++ lib.attrValues outputs.nixosModules;
            nixpkgs = {
              overlays = lib.attrValues outputs.overlays;

              config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
              };
            };
            home-manager = {
              useGlobalPkgs = true;
            };
            nix.settings = {
              experimental-features = "nix-command flakes";
              auto-optimise-store = true;

              substituters = [
                "https://hyprland.cachix.org"
                "https://helix.cachix.org"
              ];
              trusted-public-keys = [
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
              ];
            };
          })
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
          ./config
        ];
      };
    };
}
