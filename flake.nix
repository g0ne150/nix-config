{
  description = "Zapan's NixOS configuration.";
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:yaxitech/ragenix";
    agenix.inputs.darwin.follows = "";
  };
  outputs = { self, nixpkgs, home-manager, agenix, ... }: {
    nixosConfigurations.zenbook = nixpkgs.lib.nixosSystem {
      # specialArgs = { inherit agenix; };
      system = "x86_64-linux";
      modules = [
        agenix.nixosModules.default
        ./hosts/desktop/zenbook
        home-manager.nixosModules.home-manager
        ({ config, ... }: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.zapan = import ./users/zapan/home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { ageSecrets = config.age.secrets; };
          };
        })
      ];
    };

    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/desktop/nixos-vm
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.zapan = import ./users/zapan/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
