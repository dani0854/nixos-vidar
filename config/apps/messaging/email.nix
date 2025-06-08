{ pkgs, ... }:
{
  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [
      gnome-keyring
    ];
  };

  programs.thunderbird.enable = true;

  home-manager.users.main = {
    accounts.email.accounts.main = rec {
      primary = true;
      address = "suetin085@proton.me";
      aliases = [
        "suetin085@pm.me"
        "suetin085@protonmail.com"
      ];

      realName = "Danil Suetin";

      userName = address;
      passwordCommand = "secret-tool lookup email ${address}";

      imap = {
        host = "127.0.0.1";
        port = 1144;
        tls.useStartTls = true;
      };

      smtp = {
        host = "127.0.0.1";
        port = 1026;
        tls.useStartTls = true;
      };

      thunderbird.enable = true;
    };

    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        search.force = true;
      };
    };
  };
}
