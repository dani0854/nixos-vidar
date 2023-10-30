{ pkgs, ... }:

{
  home-manager.users.main = {
		qt = {
			enable = true;
			platformTheme = "gtk";
		};
  };
}
