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
    # nixpkgsのclaude-codeはリリースへの追従が遅く、npm registryから削除済みバージョンを参照してビルドが失敗することがあるため、
    # 1時間ごとに自動更新される専用flakeを使用
    claude-code = {
      url = "github:sadjow/claude-code-nix";
    };
    # 新しいnightlyでtreesitter highlighterがクラッシュするため、動作確認済みのリビジョンに固定
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/701c0a6174fde5de4b9424c0d1e5a4306b73baac";
    };
  };
  outputs =
    inputs@{ self
    , nixpkgs
    , claude-code
    , home-manager
    , nix-darwin
    , neovim-nightly-overlay
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
                nix run home-manager -- switch --flake .#darwinConfig --impure

                echo "Updating nix-darwin... 🍎"
                sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#my-macbook

                echo "Update complete! ✅"
              ''
            );
          };
        }
      );
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
      darwinConfigurations."my-macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./.config/nix/nix-darwin/default.nix
        ];
      };
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
