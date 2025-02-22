{ ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "auto";
      gpu-context = "auto";
      vo = "gpu";
      # vo = "dmabuf-wayland";
      hwdec = "auto-safe";
      dither-depth = "auto";
      # fbo-format = "rgba32f";
      # scale = "lanczos";
      script-opts = "ytdl_hook-ytdl_path=yt-dlp";
    };
  };
}
