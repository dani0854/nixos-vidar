{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
      font-awesome
    ];
    enableDefaultPackages = true;
  };
}
