# CLAUDE.md

このファイルでは、AI エージェントがこのリポジトリで作業するためのガイダンスを提供します。

## ディレクトリ設計

```
 .
 ├── .claude          # Claude Codeの設定
 ├── .config          # 各種ツールの設定ディレクトリ
 │   ├── cspell       # スペルチェッカーの設定
 │   ├── fish         # Fishシェルの設定
 │   ├── lazygit      # Lazygit（Git TUIクライアント）の設定
 │   ├── nix          # Nixパッケージマネージャーの設定
 │   ├── nvim         # Neovimの設定
 │   │   ├── after    # ファイルタイプ別の設定
 │   │   ├── init.lua # Neovimのエントリポイント
 │   │   └── lua      # Luaモジュール群
 │   │       ├── base.lua            # 基本設定（オプション、エンコーディング等）
 │   │       ├── functions.lua       # ユーティリティ関数
 │   │       ├── keymap.lua          # キーマッピング設定
 │   │       ├── plugins.lua         # プラグイン管理（lazy.nvim）
 │   │       ├── tabline.lua         # タブライン表示設定
 │   │       ├── terminal.lua        # ターミナル関連設定
 │   │       └── plugin_settings     # 各種プラグインの設定
 │   ├── starship.toml # Starshipプロンプトの設定
 │   └── yazi         # Yaziファイルマネージャーの設定
 ├── .envrc           # direnvの環境変数設定
 ├── .envrc.sample    # direnv設定のサンプル
 ├── .gitignore       # Git除外ファイル設定
 ├── .serena          # Serena MCPサーバーの設定
 ├── .tmux.conf       # tmuxターミナルマルチプレクサの設定
 ├── .vimrc           # Vimの設定
 ├── .wezterm.lua     # WezTermターミナルエミュレータの設定
 ├── CLAUDE.md        # Claude Codeへのプロジェクト指示
 ├── cspell.json      # cspellのプロジェクト設定
 ├── flake.lock       # Nix flakeのロックファイル
 ├── flake.nix        # Nix flakeの定義（パッケージ・環境管理）
 ├── README.md        # プロジェクトの説明文
 ├── setup.sh         # 初期セットアップスクリプト
 ├── stylua.toml      # StyLua（Luaフォーマッター）の設定
 └── theme.lua        # 共通テーマ設定
```

## 共通的なルール

- コミットとpushは基本的にmainブランチに対して行ってください。
- コミットメッセージは英語で書いてください。
- ファイル編集時、不要な空白は削除し、最終行には必ず改行を入れてください。
