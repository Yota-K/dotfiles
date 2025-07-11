{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      hack-font
      hackgen-font
      hackgen-nf-font
    ];
  };

  # macOS Sequoia では、nixbld ユーザーに新しいユーザー/グループ ID セットを使用する必要がある
  # ref: https://github.com/i077/system/blob/532b77c93ddc2e04ced0859b7cbb74f034d8f6bf/modules/darwin/default.nix#L15
  ids = {
    gids = {
      nixbld = 350;
    };
  };

  nix = {
    # Determinate Systemsのnix-installerでnixをインストールしたら、以下のエラーが発生したので指定している
    #
    # error: Determinate detected, aborting activation
    # Determinate uses its own daemon to manage the Nix installation that
    # conflicts with nix-darwin’s native Nix management.
    #
    # To turn off nix-darwin’s management of the Nix installation, set:
    #
    #     nix.enable = false;
    #
    # This will allow you to use nix-darwin with Determinate. Some nix-darwin
    # functionality that relies on managing the Nix installation, like the
    # `nix.*` options to adjust Nix settings or configure a Linux builder,
    # will be unavailable.
    #
    # ref: https://github.com/LnL7/nix-darwin/blob/master/README.md#prerequisites
    enable = false;
  };

  system = {
    # 下位互換性のため
    # ないとエラーで落ちた
    stateVersion = 4;

    NSGlobalDomain = {
      # システム音のボリュームを0に設定する
      "com.apple.sound.beep.volume" = 0.0;
      # キーリピート速度を設定する（短いほど速い）
      KeyRepeat = 1;
      # キーリピート開始の遅延時間を設定する（短いほど速い）
      InitialKeyRepeat = 10;
    };

    # https://daiderd.com/nix-darwin/manual/index.html
    defaults = {
      finder = {
        # 隠しファイルを常に表示するかどうか。
        AppleShowAllFiles = true;
      };
      dock = {
        # ドックを自動的に非表示または表示するかどうか。
        autohide = true;
        # ドックに最近使用したアプリケーションを表示します
        show-recents = false;
        # メニューバーの表示位置
        orientation = "left";
      };
    };
  };

  # homebrewで管理しているパッケージについて
  # - GUIアプリケーション
  #   - rubyのバージョン管理に関係するもの
  #   - postgresql系のもの
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # nix-darwin によって生成された Brewfile にリストされていないパッケージ以外はアンインストールする。
      cleanup = "uninstall";
    };
    casks = [
      "arc"
      "cursor"
      "figma"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "raycast"
      "slack"
      "tableplus"
      "wezterm@nightly"
      "zoom"
    ];
    taps = [
      "homebrew/bundle"
      "idoavrah/homebrew"
    ];
    brews = [
      "cairo"
      "glib"
      "gobject-introspection"
      "golang-migrate"
      "libffi"
      "libpq"
      "luarocks"
      "poppler"
      "postgresql@14"
      "rbenv"
      "ruby-build"
      "tftui"
    ];
  };
}
