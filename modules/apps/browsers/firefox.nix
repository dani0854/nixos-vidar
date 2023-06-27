{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    languagePacks = [ "en-US" "ru" ];
    preferences = {
      "extensions.activeThemeID" = "{f4c9e1d6-6630-4600-ad50-d223eab7f3e7}";
    };
  };
}