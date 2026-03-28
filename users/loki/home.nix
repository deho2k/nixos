{ config, pkgs,inputs, ... }:
let
dotfiles = "${config.home.homeDirectory}/dotfiles/users/loki/modules";
in
{
  home.username = "loki";
  home.homeDirectory = "/home/loki";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  home.file.".local/bin/wallpaperChange.sh".source = config.lib.file.mkOutOfStoreSymlink ./modules/scripts/wallpaperChange.sh;

  programs.bash = {
    enable = true;
    shellAliases = {
      vi = "nvim";
      qsc = "nvim ~/.config/quickshell/";
      hypr = "nvim ~/.config/hypr/";
      vic = "nvim ~/.config/nvim/";
    };
    bashrcExtra = ''
      fastImage=$(find ~/.config/walls/fetch/  -type f \( -iname '*.png' -o -iname '*.jpg' \) | shuf -n1)
      fastfetch --logo "$fastImage" --logo-type kitty --logo-width 16 --logo-height 8
      '';
  };
  programs.git = {
    userEmail = "deho2k@gmail.com";
    userName = "loki";
      extraConfig = {
        url."git@github.com:".insteadOf = "https://github.com/";
        credential.helper = "store";
      };
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  imports = [
    ./opts/packages.nix
    ./opts/config.nix
    ./modules/firefox/firefox.nix
    ./modules/nvim/nvim.nix
  ];
}
