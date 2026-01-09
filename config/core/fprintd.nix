{ pkgs, ... }:
{
  # TODO: use service.fprintd when merged:
  # https://github.com/NixOS/nixpkgs/pull/405034

  environment.systemPackages = [
    pkgs.fprintd
  ];

  systemd.packages = [ pkgs.fprintd ];

  services.dbus.packages = [ pkgs.fprintd ];
}
