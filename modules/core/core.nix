{ config, pkgs, ... }:
# TODO: Refactor
# TODO: Add comments
{
  networking.hostName = "thinkpad-nixos";

  nix.settings.auto-optimise-store = true;

  system.stateVersion = "21.05";
}

