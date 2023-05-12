{...}:
# TODO: Refactor
# TODO: Add comments
{
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ 
  	gutenprint
	  gutenprintBin
    samsung-unified-linux-driver
  ];
}