{ pkgs,inputs, ... }:

{
  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      ripgrep
      pkgs.lua-language-server
      pkgs.kdePackages.qtdeclarative
    ];
  };

}
