{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    git-crypt
    git-secrets
  ];

  home-manager.users.main.programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "Danil Suetin";
    userEmail = "suetin085@proton.me";
    signing = {
      key = "385EA9BE340A2FA8";
      signByDefault = true;
    };
    lfs.enable = true;
    aliases = {
      lola = "log --graph --decorate --pretty=\"<%C(Yellow)%h%Creset>%C(auto)%d %Cred\\\"%Creset%s%Cred\\\" %C(Yellow)[%Cgreen%ar%C(Yellow)] - %Cred%an\" --abbrev-commit --all --date=raw";
      lol = "log --graph --decorate --pretty=\"<%C(Yellow)%h%Creset>%C(auto)%d %Cred\\\"%Creset%s%Cred\\\" %C(Yellow)[%Cgreen%ar%C(Yellow)] - %Cred%an\" --abbrev-commit";
      s = "status --short";
      co = "checkout";
      b = "branch";
      bl = "blame -w -C -C -C";
      p = "push";
      pf = "push --force-with-lease";
      f = "fetch";
      r = "rebase";
      c = "commit";
      mt = "mergetool";
      cdiff = "diff-tree --no-commit-id --name-status -r HEAD";
    };
    extraConfig = {
      core = {
        autocrlf = false;
        longpaths = true;
        quotepath = false;
        editor = "hx";
      };
      merge.tool = "vimdiff";
      rerere.enabled = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
    };
  };
}
