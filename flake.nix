{
  description = "unified nix config for thinkpad and wsl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      nixvim,
      darwin,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
      
      pkgsLinux = nixpkgs.legacyPackages.${linuxSystem};
      pkgsMac = nixpkgs.legacyPackages.${macSystem};
      
      unstableLinux = import nixpkgs-unstable {
        system = linuxSystem;
        config.allowUnfree = true;
      };
      
      unstableMac = import nixpkgs-unstable {
        system = macSystem;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        specialArgs = { inherit inputs; unstable = unstableLinux; };
        modules = [
          ./hosts/thinkpad/configuration.nix
          ./hosts/thinkpad/noctalia.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; unstable = unstableLinux; };
              users.unbiased = {
                imports = [
                  ./hosts/thinkpad/home.nix
                  nixvim.homeManagerModules.nixvim
                  ./modules/home/nixvim
                ];
              };
            };
          }
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
        ];
      };

      homeConfigurations."unbiased" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsLinux;
        extraSpecialArgs = { inherit inputs; unstable = unstableLinux; };
        modules = [
          ./hosts/wsl/home.nix
          nixvim.homeManagerModules.nixvim
          ./modules/home/nixvim
        ];
      };

      darwinConfigurations."macbook" = darwin.lib.darwinSystem {
        system = macSystem;
        specialArgs = { inherit inputs; unstable = unstableMac; };
        modules = [
          ./hosts/macbook/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; unstable = unstableMac; };
              users.unbiased = {
                imports = [
                  ./hosts/macbook/home.nix
                  nixvim.homeManagerModules.nixvim
                  ./modules/home/nixvim
                ];
              };
            };
          }
        ];
      };

      templates = {
        default = {
          path = ./templates/default;
          description = "default flake template";
        };
        rust = {
          path = ./templates/rust;
          description = "rust flake template";
        };
        c = {
          path = ./templates/c;
          description = "c/c++ flake template";
        };
        python = {
          path = ./templates/python;
          description = "python flake template";
        };
      };
    };
}
