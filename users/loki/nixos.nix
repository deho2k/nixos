
{ pkgs, ... }: {
  users.users.loki = {
    isNormalUser = true;
    description = "miku";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
