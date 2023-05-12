{ ... }:

{
  services.connman = {
    enable = true;
    wifi.backend = "iwd";
  };
  
}