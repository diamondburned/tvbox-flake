{ pkgs, lib, ... }:

{
  xdg.configFile."jellyfin-mpv-shim/conf.json".source = ./jellyfin-mpv-shim-conf.json;

  xdg.autostart.enable = true;
  xdg.autostart.entries = [
    "${pkgs.jellyfin-mpv-shim}/share/applications/jellyfin-mpv-shim.desktop"
  ];
}
