{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    htop
  ];

  programs.firefox.enable = true;
}
