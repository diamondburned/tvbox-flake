{ ... }:

{
  users.users.gay_tv = {
    isNormalUser = true;
    description = "gay_tv";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.users.gay_tv = {
    imports = [ ./home.nix ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = true;
    user = "gay_tv";
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
