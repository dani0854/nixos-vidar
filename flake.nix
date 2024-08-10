{
  description = "Danil Suetin NixOS configuration. Code name: Vidar.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    waybar = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
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
              distributedBuilds = true;
              buildMachines = [
                {
                  hostName = "defiant.tail45edb.ts.net";
                  system = "x86_64-linux";
                  sshUser = "dsuetin";
                  sshKey = "/home/dsuetin/.ssh/id_ed25519";
                  publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURpU28rWWFSamhDczl2YzNvSGloZUk2a1BVQThDemhLQllGbnh2NUF0RUggcm9vdEBkZWZpYW50Cg==";
                  speedFactor = 10;
                  protocol = "ssh-ng";
                  maxJobs = 2;
                  supportedFeatures = [
                    "big-parallel"
                    "benchmark"
                    "kvm"
                  ];
                }
              ];
            };
          })
          inputs.nur.nixosModules.nur
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
          ./config
        ];
      };
    };
}
