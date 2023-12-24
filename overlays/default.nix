{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs {pkgs = final;};

  # wezterm = import ./wezterm;
}
