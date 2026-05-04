{system,pkgs,inputs, ... }:

{
  xdg.desktopEntries.discord = {
    name = "discord";
    exec = "helium discord.com/channels/@me";
    terminal = false;
    categories = [ "Utility" ];
  };
  home.packages =  [
    (pkgs.appimageTools.wrapType2 {
     pname = "helium";
     version = "0.11.7.1";
     src = pkgs.fetchurl {
       url = "https://github.com/imputnet/helium-linux/releases/download/0.11.7.1/helium-0.11.7.1-x86_64.AppImage";
       sha256 = "05bkldi1n3spsa4d4bsqk361mvfgii0k2khvnydmvr0gjbgkadxb";
     };
     extraPkgs = pkgs: with pkgs; [ ];
     })
    pkgs.quickshell
    pkgs.matugen
    pkgs.kitty
    pkgs.yazi
    pkgs.dragon-drop
    pkgs.spotify
    pkgs.awww
    pkgs.appimage-run
    pkgs.clipse
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.btop
    pkgs.fastfetch
    pkgs.playerctl
    pkgs.zip
    pkgs.obs-studio
    pkgs.pavucontrol
    pkgs.spotatui
    #neovim
    pkgs.ripgrep
    pkgs.lua-language-server
    pkgs.kdePackages.qtdeclarative
    #minecraft server
    pkgs.jdk25
    #hyprland ecosystem
    pkgs.hyprshot
    pkgs.hyprshade
    pkgs.hyprpicker
    pkgs.hypridle
  ];
}
