{ config, pkgs,inputs, ... }:

{
    imports = [
        ./opts/hardware-configuration.nix 
        ./opts/packages.nix
        ./modules/keyd.nix
        ./modules/hyprland.nix
    ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.openssh.enable = true;
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
}
