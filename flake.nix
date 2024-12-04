{
  description = "My package list.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # Flake関連のユーティリティ関数
    # マルチプラットフォーム対応を行うために使用している。
    # https://github.com/numtide/flake-utils?tab=readme-ov-file#system---system--system--
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly-overlay,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      # NOTE: let-in構文を使うことで関数内で変数を宣言できる
      let
        pkgs = import nixpkgs {
          system = system;
          # Unfreeパッケージをインストールできるようにする
          # ref: https://nixos.org/manual/nixpkgs/stable/#sec-allow-unfree
          config.allowUnfree = true;
          overlays = [ neovim-nightly-overlay.overlays.default ];
        };
      in
      {
        allowUnfree = true;

        packages.my-packages = pkgs.buildEnv {
          name = "my-packages";
          paths = with pkgs; [
            alacritty
            bat
            curl
            deno
            direnv
            eza
            git
            gitflow
            graphviz
            jq
            lazygit
            libffi
            libssh2
            libzip
            neovim
            ngrok
            nixfmt-rfc-style
            rbenv
            ripgrep
            starship
            tig
            tmux
            unbound
            vim
            vips
            volta
            zellij
          ];
        };

        # nix run .#updateで以下のスクリプトを実行する
        # - nix flake update: flakeのlockファイルを更新する
        # - nix profile upgrade my-packages: 最新のフレークを使用してパッケージをアップグレードする
        apps.update = {
          type = "app";
          program = toString (
            pkgs.writeShellScript "update-script" ''
              set -e
              echo "Updating flake..."
              nix flake update
              echo "Updating profile..."
              nix profile upgrade my-packages
              echo "Update complete!"
            ''
          );
        };

        #  nixfmtを使用して、formatter実行できるようにする
        # nix fmt でフォーマッターを実行できる
        # https://github.com/NixOS/nixfmt
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
