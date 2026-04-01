{pkgs,inputs, ... }:

{
  xdg.desktopEntries.discord = {
    name = "discord";
    exec = "firefox discord.com/channels/@me";
    terminal = false;
    categories = [ "Utility" ];
  };
  home.packages =  [
    pkgs.quickshell
    pkgs.matugen
    pkgs.kitty
    pkgs.yazi
    pkgs.dragon-drop
    pkgs.spotify
    pkgs.swww
    pkgs.appimage-run
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.btop
    pkgs.fastfetch
    pkgs.playerctl
    pkgs.zip

#neovim
    pkgs.ripgrep
    pkgs.lua-language-server
    pkgs.kdePackages.qtdeclarative

#minecraft server
    pkgs.jdk17
#hyprland ecosystem
    pkgs.hyprshot
    pkgs.hyprshade
    pkgs.hyprpicker
    pkgs.hypridle
    ];
}
