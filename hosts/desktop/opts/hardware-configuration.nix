{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/8778f1d5-a4a3-4a29-ba7c-a1576f76af60";
        fsType = "ext4";
    };

    fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C6B9-BD38";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };


    hardware.graphics = { enable = true; };
    swapDevices =[ { device = "/dev/disk/by-uuid/7424f8ff-d183-4f4e-b9b1-4fde1cd026bd"; } ];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
}
