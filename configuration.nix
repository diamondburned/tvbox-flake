{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  inherit (inputs)
    sops-nix
    home-manager
    ;
in

{
  imports = [
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager

    ./system/graphics.nix
    ./system/hardware-configuration.nix
    ./system/networking.nix
    ./system/programs.nix
    ./system/region.nix
    ./system/ssh.nix

    ./users/gay_tv
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      {
        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "24.11";
      }
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  services.journald.extraConfig = ''
    SystemMaxUse=2G
    MaxRetentionSec=3month
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
