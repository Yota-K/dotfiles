{ inputs
, lib
, config
, pkgs
, ...
}:
let
  username = builtins.getEnv "DARWIN_USER";

  cliTools = with pkgs; [
    awscli2
    aws-sam-cli
    bat
    curl
    ctop
    delta
    deno
    direnv
    docker
    docker-compose
    eza
    fish
    fzf
    git
    gitflow
    go
    graphviz
    jq
    lazygit
    ngrok
    nixfmt-rfc-style
    ripgrep
    starship
    stylua
    tenv
    tig
    vim-startuptime
    volta
    yazi
  ];
  editors = with pkgs; [
    neovim # neovim-nightly
    vim
  ];
  libraries = with pkgs; [
    libssh2
    libzip
    lua
    perl
    php
    ruby
    rbenv
    rustup
    vips
  ];
  terminalPackages = with pkgs; [
    alacritty
    tmux
    zellij
  ];
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
    packages = cliTools ++ editors ++ libraries ++ terminalPackages;
  };

  programs.home-manager = {
    enable = true;
  };
}
