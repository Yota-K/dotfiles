{
  description = "My nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , nix-darwin
    ,
    }:
    let
      supportSystems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportSystems;
    in
    {
      ########################################
      # nix run .#update
      ########################################
      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          update = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "update-script" ''
                set -e
                echo "Updating flake... ⚙️"
                nix flake update

                echo "Updating home-manager... 🏠"
                nix run nixpkgs#home-manager -- switch --flake .#darwinConfig --impure

                echo "Updating nix-darwin... 🍎"
                sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#my-macbook

                echo "Update complete! ✅"
              ''
            );
          };
        }
      );

      ########################################
      # home-manager
      ########################################
      homeConfigurations = {
        darwinConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [
            ./.config/nix/home-manager/home.nix
          ];
        };
      };

      ########################################
      # nix-darwin
      ########################################
      darwinConfigurations."my-macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./.config/nix/nix-darwin/default.nix
        ];
      };

      ########################################
      # formatter
      ########################################
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
