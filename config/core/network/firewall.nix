{ ... }: {
  networking.firewall = {
    checkReversePath = "loose";
  };
}
