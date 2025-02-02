{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      hack-font
      hackgen-font
      hackgen-nf-font
    ];
  };

  system = {
    # 下位互換性のため
    # ないとエラーで落ちた
    stateVersion = 4;

    # https://daiderd.com/nix-darwin/manual/index.html
    defaults = {
      # Finder ですべてのファイル拡張子を表示するかどうか
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder = {
        # 隠しファイルを常に表示するかどうか。
        AppleShowAllFiles = true;
        # ファイル拡張子を常に表示するかどうか
        AppleShowAllExtensions = true;
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

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # nix-darwin によって生成された Brewfile にリストされていないパッケージ以外はアンインストールする。
      cleanup = "uninstall";
    };
    brews = [
      "cairo"
      "glib"
      "gobject-introspection"
      "libffi"
      "libpq"
      "luarocks"
      "poppler"
      "postgresql@14"
      "ruby-build"
      "golang-migrate"
    ];
    casks = [
      "arc"
      "figma"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "raycast"
      "sequel-ace"
      "slack"
      "wezterm@nightly"
      "zoom"
      "tableplus"
    ];
    taps = [
      "homebrew/bundle"
    ];
  };
}
