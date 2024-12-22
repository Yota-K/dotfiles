{
  description = "My package list.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs =
    { self, nixpkgs, neovim-nightly-overlay }:
    let
      supportSystems = [
        "x86_64-darwin" # macOS (64-bit x86)
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true; # Unfreeパッケージを許可
            overlays = [ neovim-nightly-overlay.overlays.default ];
          };
        in
        {
          allowUnfree = true;

          my-packages = pkgs.buildEnv {
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
              go
              graphviz
              jq
              lazygit
              libffi
              libssh2
              libzip
              lua
              neovim
              ngrok
              nixfmt-rfc-style
              perl
              php
              ripgrep
              rustup
              starship
              tig
              tmux
              vim
              vips
              volta
              zellij
            ];
          };
        }
      );

      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            system = system;
          };
        in
        {
          update = {
            type = "app";
            program = toString (pkgs.writeShellScript "update-script" ''
              set -e
              echo "Updating flake..."
              nix flake update
              echo "Updating profile..."
              nix profile upgrade my-packages
              echo "Update complete!"
            '');
          };
        }
      );

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
