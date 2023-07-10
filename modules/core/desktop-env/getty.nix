{ config, ... }:

{
	services.getty.autologinUser = config.users.users.main
}
