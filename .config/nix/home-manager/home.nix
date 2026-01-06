{
  inputs,
  pkgs,
  ...
}:
let
  tools = with pkgs; [
    # aws-sam-cli
    aws-vault
    awscli2
    bat
    claude-code
    curl
    ctop
    delta
    deno
    direnv
    ecspresso
    eza
    fish
    fzf
    gh
    git
    gitflow
    go
    google-cloud-sdk
    google-cloud-sql-proxy
    graphviz
    jq
    lazygit
    libssh2
    libzip
    lua
    ngrok
    nixfmt-rfc-style
    orbstack
    perl
    php
    pyenv
    ripgrep
    rustup
    starship
    stylua
    tenv
    tig
    uv
    vim-startuptime
    vips
    volta
    yazi
  ];
  editors = with pkgs; [
    vim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
  terminalPackages = with pkgs; [
    alacritty
    tmux
    zellij
  ];
  username = "public";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
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
