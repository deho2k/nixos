{ config, pkgs,inputs, ... }:

{
  imports = [
    ./opts/hardware-configuration.nix 
      ./opts/packages.nix
      ./modules/keyd.nix
      ./modules/hyprland.nix
      ./modules/keyboardLight.nix
  ];

  services.openssh.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 22 ];
  };
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev"; # "nodev" is used for UEFI
      efiSupport = true;
      useOSProber = true;
    };
  };
#boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "miku";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jerusalem";
  nixpkgs.config.allowUnfree = true;

#remove unnceary packages
  services.xserver = { 
    enable = true; 
    excludePackages = [ 
      pkgs.xterm
    ];
  };
  documentation.nixos.enable = false;

  environment.localBinInPath = true;
  services.displayManager.ly.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="  ];
  };
  system.stateVersion = "26.05";
}
