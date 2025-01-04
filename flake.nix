{
  description = "My package list.";
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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs =
    inputs@{ self, nixpkgs, neovim-nightly-overlay, nix-darwin, home-manager }:
    let
      supportSystems = [
        "x86_64-darwin" # 64-bit x86 macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportSystems;
    in
    {
      # Executed by `nix run .#<name>`
      # https://nixos.wiki/wiki/Flakes#Output_schema
      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          # DARWIN_USERには自分のユーザ名をセットする
          # env DARWIN_USER=your_username nix run .#update
          update = {
            type = "app";
            program = toString (pkgs.writeShellScript "update-script" ''
              set -e
              echo "Updating flake... ⚙️"
              nix flake update
              echo "Updating home-manager... 🏠"
              # --impureフラグをつけることで、ビルド中に環境変数にアクセスすることを許可する
              nix run nixpkgs#home-manager -- switch --flake .#darwinConfig --impure
              echo "Updating nix-darwin... 🍎"
              nix run nix-darwin -- switch --flake .#my-macbook
              echo "Update complete! ✅"
            '');
          };
        }
      );

      # Executed by `nix build .#<name>`
      # https://nixos.wiki/wiki/Flakes#Output_schema
      packages = forAllSystems (
        system:
        {
          homeConfigurations = {
            darwinConfig = home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                inherit system;
              };
              extraSpecialArgs = {
                inherit inputs;
              };
              modules = [
                ./.config/nix/home-manager/home.nix
              ];
            };
          };

          darwinConfigurations."my-macbook" = nix-darwin.lib.darwinSystem {
            system = system;
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./.config/nix/nix-darwin/default.nix ];
          };
        }
      );

      # Formatter (alejandra, nixfmt or nixpkgs-fmt)
      # https://nixos.wiki/wiki/Flakes#Output_schema
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
