{ inputs }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
        packages = ((flake.packages or { }).${final.system} or { });
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };

  # wezterm = import ./wezterm;
}
