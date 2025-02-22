{ pkgs, lib, ... }:

{
  imports = [
    ./jellyfin-mpv
  ];

  home.packages = with pkgs; [
    steam
    gnome-usage
    mission-center

    # GNOME junks.
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.tailscale-qs
  ];

  pam.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };
}
