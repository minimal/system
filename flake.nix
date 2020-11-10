{
  description = "darwin system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, home-manager, nixpkgs }: {
    darwinConfigurations."Randall" = darwin.lib.darwinSystem {
      modules =
        [ ./darwin-configuration.nix home-manager.darwinModules.home-manager ];
    };
    nixosConfigurations."Phil" = nixpkgs.lib.nixosSystem {
      modules =
        [ ./configuration.nix home-manager.nixosModules.home-manager ];
    };
  };
}