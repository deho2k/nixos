{pkgs,inputs, ... }:
{
  environment.systemPackages = [
    pkgs.git
    pkgs.brightnessctl
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
  services.upower.enable = true;
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-color-emoji
  ];
}
