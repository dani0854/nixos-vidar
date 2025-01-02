{
  description = "Danil Suetin NixOS configuration. Code name: Vidar.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    hyprland = {
      # https://github.com/hyprwm/Hyprland/pull/5667
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "hyprland/systems";
        hyprutils.follows = "hyprland/hyprutils";
        hyprlang.follows = "hyprland/hyprlang";
      };
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      treefmtEval = inputs.treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix;
    in
    {
      # Custom packages
      # Accessible through `nix build`, `nix shell`, etc
      packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

      # `nix fmt`
      formatter.${system} = treefmtEval.config.build.wrapper;

      # `nix flake check`
      checks.${system} = {
        formatting = treefmtEval.config.build.check self;
      };

      # Packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

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
              nixpkgs = {
                overlays = lib.attrValues outputs.overlays;

                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = (_: true);
                };
              };
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
                  max-jobs = 1;
                  cores = 8;

                  system-features = [
                    "big-parallel"
                    "kvm"
                    "nixos-test"
                  ];

                  substituters = [
                    "https://hyprland.cachix.org"
                    "https://helix.cachix.org"
                  ];
                  trusted-public-keys = [
                    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                    "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
                  ];
                };
                # distributedBuilds = true;
                # buildMachines = [
                #   {
                #     hostName = "defiant.tail45edb.ts.net";
                #     system = "x86_64-linux";
                #     sshUser = "dsuetin";
                #     sshKey = "/home/dsuetin/.ssh/id_ed25519";
                #     publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURpU28rWWFSamhDczl2YzNvSGloZUk2a1BVQThDemhLQllGbnh2NUF0RUggcm9vdEBkZWZpYW50Cg==";
                #     speedFactor = 10;
                #     protocol = "ssh-ng";
                #     maxJobs = 2;
                #     supportedFeatures = [
                #       "big-parallel"
                #       "benchmark"
                #       "kvm"
                #     ];
                #   }
                # ];
              };
            }
          )
          inputs.nur.modules.nixos.default
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
          ./config
        ];
      };
    };
}
