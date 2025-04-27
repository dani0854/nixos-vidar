{ ... }:
let
  wallpaper = builtins.toString ./wallpaper.png;
in
{
  home-manager.users.main.services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaper ];
      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
