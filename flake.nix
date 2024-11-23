{
  description = "My package list for mac os.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-darwin.my-packages = nixpkgs.legacyPackages.x86_64-darwin.buildEnv {
      name = "my-packages";
      paths = [
        # エラーで落ちたのでコメントアウト
        # nixpkgs.legacyPackages.x86_64-darwin.aws-sam-cli
        nixpkgs.legacyPackages.x86_64-darwin.alacritty
        nixpkgs.legacyPackages.x86_64-darwin.bat
        # エラーで落ちたのでコメントアウト
        # nixpkgs.legacyPackages.x86_64-darwin.deno
        nixpkgs.legacyPackages.x86_64-darwin.curl
        nixpkgs.legacyPackages.x86_64-darwin.direnv
        nixpkgs.legacyPackages.x86_64-darwin.eza
        nixpkgs.legacyPackages.x86_64-darwin.git
        nixpkgs.legacyPackages.x86_64-darwin.jq
        nixpkgs.legacyPackages.x86_64-darwin.lazygit
        nixpkgs.legacyPackages.x86_64-darwin.ripgrep
        nixpkgs.legacyPackages.x86_64-darwin.tig
        nixpkgs.legacyPackages.x86_64-darwin.vim
        nixpkgs.legacyPackages.x86_64-darwin.volta
        nixpkgs.legacyPackages.x86_64-darwin.zellij
      ];
    };
  };
}
