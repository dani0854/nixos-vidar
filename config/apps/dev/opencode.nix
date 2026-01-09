{ ... }:
{
  home-manager.users.main.programs.opencode = {
    enable = true;
    settings = {
      theme = "nord";
      default_agent = "plan";
      autoupdate = false;
    };
  };
}
