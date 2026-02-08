-- wezterm, nvim共通で使用するtheme module
local THEME = {}

-- テーマを管理
local theme_config = {
  name = "bamboo_multiplex",
  bamboo = {
    bg = "#252623",
    wezterm = "Bamboo",
  },
  bamboo_multiplex = {
    bg = "#232923",
    wezterm = "Bamboo Multiplex",
  },
  carbonfox = {
    bg = "#161616",
    wezterm = "carbonfox",
  },
  gruvbox = {
    bg = "#282828",
    wezterm = "Gruvbox Dark (Gogh)",
  },
  nightfox = {
    bg = "#172331",
    wezterm = "nightfox",
  },
}

-- 色を管理
local colors = {
  yellow = "#ffe64d",
  selected_blue = "#8080ff",
  blue = "#6fc3df",
  aliceblue = "#f0f8ff",
  peru = "#cd853f",
  black = "#000",
  white = "#fff",
  none = "none",
  git_diff = {
    added = "#99c794",
    modified = "#5bb7b8",
    removed = "#ec5f67",
  },
}

-- 使用テーマをTHEMEモジュール経由で取得できるようにする
THEME.theme_config = theme_config
THEME.selected_theme = theme_config["name"]
THEME.colors = colors

-- ファイルの最後でテーブルを返すことでモジュールとして扱えるようにする
return THEME
