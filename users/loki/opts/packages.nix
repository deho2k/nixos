{pkgs,inputs, ... }:

{
  imports = [
    inputs.matugen.nixosModules.default
  ];
  xdg.desktopEntries.discord = {
    name = "discord";
    exec = "firefox discord.com/channels/@me";
    terminal = false;
    categories = [ "Utility" ];
  };
  home.packages =  [
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.matugen.packages.${pkgs.system}.default
    pkgs.kitty
    pkgs.yazi
    pkgs.dragon-drop
    pkgs.spotify
    pkgs.steam
    pkgs.swww
    pkgs.appimage-run
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.btop
    pkgs.fastfetch
    pkgs.playerctl

    pkgs.jdk17
#hyprland ecosystem
    pkgs.hyprshot
    pkgs.hyprshade
    pkgs.hyprpicker
    pkgs.hypridle
    ];
}
