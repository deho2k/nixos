{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    matugen.url = "github:/InioX/Matugen";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self, 
    nixpkgs,
    neovim-nightly-overlay,
    home-manager,
    quickshell,
    matugen,
    ... } @ inputs: {
      nixosConfigurations.miku = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.loki = import ./users/loki/home.nix;
                backupFileExtension = "backup";
              };
            }
        ];
      };
    };
}
