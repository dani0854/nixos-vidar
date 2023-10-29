{ pkgs, ... }:

{
  home-manager.users.main = {
		gtk = {
			enable = true;
			theme = {
				package = pkgs.nordic;
				name = "Nordic";
			};
			font.name = "FiraCode";
			iconTheme = {
				package = pkgs.nordzy-icon-theme;
				name = "Nordzy";
			};
		};
  };
}
