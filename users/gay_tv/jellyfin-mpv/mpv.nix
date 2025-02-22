{ pkgs, lib, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "auto";
      gpu-context = "auto";
      vo = "dmabuf-wayland";
      hwdec = "auto-safe";
      dither-depth = "auto";
      script-opts = "ytdl_hook-ytdl_path=${lib.getExe pkgs.yt-dlp}";
    };
  };
}
