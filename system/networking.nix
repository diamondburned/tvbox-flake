{ pkgs, lib, ... }:

{
  networking.hostName = "moguchan";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "both";
  };
}
