{pkgs,inputs, ... }:
{
  environment.systemPackages = [
    pkgs.git
<<<<<<< HEAD
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
=======
>>>>>>> origin/qsRevamp
  ];
  programs.neovim.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-color-emoji
  ];
}
