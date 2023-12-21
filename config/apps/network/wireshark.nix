{pkgs, ...}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.main.extraGroups = ["wireshark"];
}
