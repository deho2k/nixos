{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
  let
    # Define common modules used by every host
    shared-modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          backupFileExtension = "backup";
        };
      }
    ];
    user-loki = [
      ./users/loki/nixos.nix
      { home-manager.users.loki = import ./users/loki/home.nix; }
    ];
    user-server = [
      ./users/server/nixos.nix
      { home-manager.users.server = import ./users/server/home.nix; }
    ];
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./hosts/desktop/configuration.nix ]
                  ++ user-loki
                  ++ shared-modules;
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./hosts/laptop/configuration.nix ]
                  ++ user-loki
                  ++ shared-modules;
      };

      server = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./hosts/server/configuration.nix ]
                  ++ user-loki
                  ++ shared-modules;
      };
    };
  };
}
