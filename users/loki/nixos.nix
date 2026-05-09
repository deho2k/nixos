
{ pkgs,inputs, ... }: {
  programs.hyprland.enable = true;
  users.users.loki = {
    isNormalUser = true;
    description = "miku";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
