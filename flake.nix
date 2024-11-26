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

  outputs = { self, nixpkgs, neovim-nightly-overlay, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    # NOTE: let-in構文を使うことで関数内で変数を宣言できる
    let
      # NOTE: Overlaysという仕組みを利用することでNixpkgsを拡張・上書きすることができる
      pkgs = nixpkgs.legacyPackages.${system}.extend (neovim-nightly-overlay.overlays.default);
    in
    {
      packages.my-packages = pkgs.buildEnv {
        name = "my-packages";
        paths = with pkgs; [
          # エラーで落ちたのでコメントアウト
          # nixpkgs.legacyPackages.${system}.aws-sam-cli
          alacritty
          bat
          # エラーで落ちたのでコメントアウト
          # nixpkgs.legacyPackages.${system}.deno
          curl
          direnv
          eza
          git
          jq
          lazygit
          ripgrep
          tig
          tmux
          vim
          volta
          zellij
          neovim
        ];
      };
    }
  );
}
