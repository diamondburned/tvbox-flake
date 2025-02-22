{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f3718d67-71cb-4685-8a3c-8c0835d6928e";
    fsType = "ext4";
  };

  boot.initrd.luks.devices = {
    "luks-cfc198df-297b-45fd-af39-853f7f8985e6".device =
      "/dev/disk/by-uuid/cfc198df-297b-45fd-af39-853f7f8985e6";
    "luks-a91f7f19-d27d-49a6-b7ef-2d4ade66d8f1".device =
      "/dev/disk/by-uuid/a91f7f19-d27d-49a6-b7ef-2d4ade66d8f1";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5FDB-BFE6";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/8ae10d3e-74f5-4e2a-91fb-2fe62d44f5b7"; }
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
