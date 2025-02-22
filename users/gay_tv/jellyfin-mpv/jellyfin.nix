{ pkgs, lib, ... }:

{
  systemd.user.services.jellyfin-mpv-shim = {
    Unit = {
      Description = "Jellyfin MPV shim";
    };
    Service = {
      ExecStart = lib.getExe pkgs.jellyfin-mpv-shim;
      Restart = "always";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.configFile."jellyfin-mpv-shim/conf.json".source = ./jellyfin-mpv-shim-conf.json;
}
