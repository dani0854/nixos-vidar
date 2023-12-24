{ ... }: {
  users.users.main = {
    name = "dsuetin";
    uid = 1000;
    isNormalUser = true;
  };

  home-manager.users.main = {
    home.stateVersion = "22.11";
  };
}
