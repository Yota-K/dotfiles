{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      hack-font
      hackgen-font
      hackgen-nf-font
    ];
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
    primaryUser = "public";

    # 下位互換性のため
    # ないとエラーで落ちた
    stateVersion = 4;

    # https://daiderd.com/nix-darwin/manual/index.html
    defaults = {
      NSGlobalDomain = {
        # ダークモード
        AppleInterfaceStyle = "Dark";
        # 24時間表示
        AppleICUForce24HourTime = true;
        # サイドバーのアイコンサイズ (1=小, 2=中, 3=大)
        NSTableViewDefaultSizeMode = 2;
        # システム音のボリュームを0に設定する
        "com.apple.sound.beep.volume" = 0.0;
        # キーリピート速度を設定する（短いほど速い）
        KeyRepeat = 1;
        # キーリピート開始の遅延時間を設定する（短いほど速い）
        InitialKeyRepeat = 10;
        # スマートダッシュを無効化
        NSAutomaticDashSubstitutionEnabled = false;
        # スマート引用符を無効化
        NSAutomaticQuoteSubstitutionEnabled = false;
      };
      finder = {
        # 隠しファイルを常に表示するかどうか。
        AppleShowAllFiles = true;
        # すべてのファイル拡張子を表示するかどうか
        AppleShowAllExtensions = true;
        # Finderの終了を許可するか
        # ナビゲーションバーに終了等選択肢が表示されるようになる。Dockからは終了できない。
        QuitMenuItem = true;
      };
      dock = {
        # ドック内のアイコンのサイズ。デフォルトは64
        tilesize = 40;
        # ドックを自動的に非表示または表示するかどうか
        autohide = true;
        # ドックに最近使用したアプリケーションを表示します
        show-recents = false;
        # メニューバーの表示位置
        orientation = "left";
      };
      screencapture = {
        # ディレクトリを作成する必要あり
        # https://github.com/nix-darwin/nix-darwin/issues/1240
        location = "~/Documents/screenshot";
        # 使用する画像の拡張子
        type = "png";
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
      # home-managerで入れようとしたらエラーになった
      "gemini-cli"
      "gobject-introspection"
      "golang-migrate"
      "libffi"
      "libvips"
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
