{pkgs,inputs, ... }:
{
  environment.systemPackages = [
    pkgs.git
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
  programs.neovim.enable = true;
  programs.steam.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-color-emoji
  ];
}
