{
  description = "Zapan's NixOS configuration.";
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.darwin.follows = "";
    };

    # nvf = {
    #   url = "github:NotAShelf/nvf";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    lazyvim = {
      url = "github:g0ne150/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      # nvf,
      lazyvim,
      ...
    }:
    {
      nixosConfigurations.zenbook = nixpkgs.lib.nixosSystem {
        # specialArgs = { inherit agenix; };
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          ./hosts/desktop/zenbook
          home-manager.nixosModules.home-manager
          (
            { config, ... }:
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.zapan = import ./users/zapan/home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  ageSecrets = config.age.secrets;
                  # inherit nvf;
                  inherit lazyvim;
                };
              };
            }
          )
        ];
      };

      nixosConfigurations.clawdbot = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/clawdbot
        ];
      };

    };
}
