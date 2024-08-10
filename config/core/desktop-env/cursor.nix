{ pkgs, ... }:

{
  home-manager.users.main.home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Nord)";
    size = 16;
  };
}
