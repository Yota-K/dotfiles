-- wezterm, nvim共通で使用するtheme module
local THEME = {}

-- テーマを管理
local theme_config = {
  name = "catppuccin",
  nightfox = {
    bg = "#172331",
    wezterm = "nightfox",
  },
  carbonfox = {
    bg = "#161616",
    wezterm = "carbonfox",
  },
  gruvbox = {
    bg = "#282828",
    wezterm = "Gruvbox Dark (Gogh)",
  },
  vscode = {
    bg = "#1e1e1e",
    wezterm = "Vs Code Dark+ (Gogh)",
  },
  catppuccin = {
    bg = "#1e1e2e",
    border_color = "#6c7086",
    wezterm = "Catppuccin Mocha",
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

-- テーマの上書きを行うための関数
local function theme_override_settings(theme_type)
  local base_theme = {
    -- -- 補完メニューのスクロールバーの色
    -- PmenuThumb = { bg = colors["white"] },
    -- -- 境界線の色
    -- VertSplit = { fg = colors["blue"] },
    -- -- 選択時の色: 視認性重視
    -- Visual = { fg = colors["white"], bg = colors["selected_blue"] },
    -- -- コマンドモードの結果を出力する時の上部に表示される背景色を透過させる
    StatusLine = { fg = colors["none"], bg = colors["none"] },
    -- エラーやヒントの記号を表示するための表示領域
    -- 背景色があると鬱陶しいので透過させる
    SignColumn = { fg = colors["none"], bg = colors["none"] },
  }

  -- coc.nvim
  local coc_theme = {
    -- 補完メニューのホバーしたときの色
    CocMenuSel = { bg = "#73daca", fg = "bg0" },
    -- フローティングウィンドウの色
    CocFloating = { bg = "#002b36" },
  }

  -- どのテーマでも絶対に有効にしたい色の設定
  vim.cmd([[
    augroup highlightIdegraphicSpace
      autocmd!
      autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
      autocmd VimEnter,WinEnter * match IdeographicSpace /　/
    augroup END

    autocmd ColorScheme * highlight StatusLine NONE
    autocmd ColorScheme * highlight TabLineFill ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn NONE
  ]])

  if theme_type == "nightfox" then
    base_theme["CocMenuSel"] = coc_theme["CocMenuSel"]
    -- フローティングウィンドウの色
    base_theme["NormalFloat"] = { bg = "#3b474a" }
  elseif theme_type == "carbonfox" then
    base_theme["CocFloating"] = coc_theme["CocFloating"]
  end

  return base_theme
end

-- 使用テーマをTHEMEモジュール経由で取得できるようにする
THEME.theme_config = theme_config
THEME.selected_theme = theme_config["name"]
THEME.colors = colors
THEME.theme_override_settings = theme_override_settings

-- ファイルの最後でテーブルを返すことでモジュールとして扱えるようにする
return THEME
