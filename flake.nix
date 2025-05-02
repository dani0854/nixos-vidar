{
  description = "Danil Suetin NixOS configuration. Code name: Vidar.";

  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    inputs.flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        inherit (self) outputs;

        overlays = import ./overlays;

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            overlays
            inputs.nur.overlays.default
          ];
          config.allowUnfree = true;
        };

        treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        # Accessible through `nix build`, `nix shell`, etc
        legacyPackages.${system} = pkgs;

        # `nix fmt`
        formatter.${system} = treefmtEval.config.build.wrapper;

        # `nix flake check`
        checks.${system} = {
          formatting = treefmtEval.config.build.check self;
        };

        # Packages and modifications, exported as overlays
        overlays.default = overlays;

        # NixOS modules you might want to export
        nixosModules = import ./modules;

        nixosConfigurations.vidar = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            (
              { lib, ... }:
              {
                imports = [
                  inputs.home-manager.nixosModules.home-manager
                ] ++ lib.attrValues outputs.nixosModules;
                nixpkgs.pkgs = pkgs;
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bkp";
                };
                hardware.enableRedistributableFirmware = true;
                nix = {
                  settings = {
                    experimental-features = "nix-command flakes";
                    auto-optimise-store = true;
                    max-jobs = 3;
                    cores = 4;

                    system-features = lib.mkForce [
                      "kvm"
                      "nixos-test"
                    ];

                    trusted-users = [
                      "dsuetin"
                    ];
                  };
                };
              }
            )
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
            ./config
          ];
        };
      }
    );
}
