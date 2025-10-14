{
  inputs,
  pkgs,
  ...
}:
let
  username = builtins.getEnv "DARWIN_USER";

  tools = with pkgs; [
    aws-sam-cli
    aws-vault
    awscli2
    bat
    curl
    ctop
    delta
    deno
    direnv
    docker
    docker-compose
    ecspresso
    eza
    fish
    fzf
    gh
    git
    gitflow
    go
    graphviz
    jq
    lazygit
    libssh2
    libzip
    lua
    ngrok
    nixfmt-rfc-style
    perl
    php
    pyenv
    ripgrep
    ruby
    rustup
    starship
    stylua
    tenv
    tig
    vim-startuptime
    vips
    volta
    yazi
  ];
  editors = with pkgs; [
    neovim # neovim-nightly
    vim
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
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
    package = pkgs.nix;
  };

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
    packages = tools ++ editors ++ terminalPackages;
  };

  programs.home-manager = {
    enable = true;
  };
}
