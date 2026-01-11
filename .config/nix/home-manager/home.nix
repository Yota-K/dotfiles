{
  inputs,
  pkgs,
  ...
}:
let
  # CLI/TUI系
  cliTools = with pkgs; [
    bat
    claude-code
    curl
    delta
    direnv
    eza
    fish
    fzf
    jq
    ripgrep
    starship
    tenv
    vim-startuptime
    yazi
  ];

  # パブリッククラウド/コンテナ関連
  cloudTools = with pkgs; [
    aws-vault
    awscli2
    ctop
    ecspresso
    google-cloud-sdk
    google-cloud-sql-proxy
    minikube
    ngrok
    orbstack
  ];

  # Editors
  editors = with pkgs; [
    vim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  # コードフォーマッタ
  formatters = with pkgs; [
    nixfmt-rfc-style
    stylua
  ];

  # Git関連ツール
  gitTools = with pkgs; [
    gh
    git
    gitflow
    lazygit
  ];

  # プログラミング言語/ランタイム/バージョン管理/パッケージマネージャ
  languages = with pkgs; [
    deno
    go
    lua
    perl
    php
    pyenv
    rustup
    uv
    volta
  ];

  # その他
  others = with pkgs; [
    graphviz
    libssh2
    libzip
    vips
  ];

  # ターミナル関連
  terminals = with pkgs; [
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
    packages =
      cliTools ++ cloudTools ++ editors ++ formatters ++ gitTools ++ languages ++ others ++ terminals;
  };

  programs.home-manager = {
    enable = true;
  };
}
