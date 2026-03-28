{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self, 
    nixpkgs,
    neovim-nightly-overlay,
    home-manager,
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
