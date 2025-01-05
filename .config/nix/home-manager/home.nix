{ inputs
, lib
, config
, pkgs
, ...
}:
let
  username = builtins.getEnv "DARWIN_USER";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
  };

  nix = {
    settings = {
      # FlakesとNix commandをはNixの実験的機能なので、experimental-featuresフィールドに追加する
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nix;
  };

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";

    packages = with pkgs; [
      alacritty
      awscli
      bat
      curl
      ctop
      deno
      direnv
      docker
      docker-compose
      eza
      fish
      git
      gitflow
      go
      graphviz
      jq
      lazygit
      libssh2
      libzip
      lua
      neovim # neovim-nightly
      ngrok
      nixfmt-rfc-style
      perl
      php
      ruby
      rbenv
      ripgrep
      rustup
      starship
      stylua
      tig
      tmux
      vim
      vips
      volta
      zellij
    ];
  };

  programs.home-manager = {
    enable = true;
  };
}
