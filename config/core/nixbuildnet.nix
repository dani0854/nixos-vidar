{ config, lib, ... }:
{
  programs.ssh = {
    extraConfig =
      let
        nixbuildVars = {
          NIXBUILDNET_MAX_SILENT_TIME = 15 * 60;
          NIXBUILDNET_TIMEOUT = 2 * 60 * 60;
          NIXBUILDNET_KEEP_BUILDS_RUNNING = true;
          NIXBUILDNET_REUSE_BUILD_TIMEOUTS = true;
          NIXBUILDNET_SUBSTITUTERS = builtins.concatStringsSep "," config.nix.settings.substituters;
          NIXBUILDNET_TRUSTED_PUBLIC_KEYS = builtins.concatStringsSep "," config.nix.settings.trusted-public-keys;
        };

        toInlineShellVars = vars: builtins.replaceStrings [ "\n" ] [ " " ] (lib.strings.toShellVars vars);
      in
      ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          ServerAliveInterval 60
          IPQoS throughput
          IdentityFile ${config.users.users.main.home}/.ssh/id_ed25519
          SetEnv ${toInlineShellVars nixbuildVars}
      '';
    knownHosts = {
      nixbuild = {
        hostNames = [ "eu.nixbuild.net" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
      };
    };
  };

  nix = {
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        speedFactor = 100;
        maxJobs = 25;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
        ];
      }
    ];
  };
}
