{ config, pkgs,inputs, ... }:
let

dotfiles = "${config.home.homeDirectory}/dotfiles/users/loki/modules";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
  nvim = "nvim/nvim";
  hypr = "hypr";
  fastfetch = "fastfetch";
  kitty = "kitty";
  quickshell = "quickshell";
  matugen = "matugen";
  walls = "walls";
};
in
{
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
     source = create_symlink "${dotfiles}/${subpath}";
     recursive = true;
     })
  configs;
}
