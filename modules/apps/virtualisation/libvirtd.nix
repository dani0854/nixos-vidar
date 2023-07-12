{ pkgs, ... }:

{
	virtualisation.libvirtd.enable = true;

	environment.systemPackages = with pkgs; [
		virt-manager
	];

	users.users.main.extraGroups = [ "libvirtd" ];
}
