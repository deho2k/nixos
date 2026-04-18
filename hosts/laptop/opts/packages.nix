{pkgs,inputs, ... }:
{
  environment.systemPackages = [
    pkgs.git
    pkgs.brightnessctl
    pkgs.tcpdump
    pkgs.traceroute
  ];
  services.upower.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-color-emoji
  ];
}
