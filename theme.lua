-- wezterm, nvim共通で使用するtheme module
local THEME = {}

-- 色を管理
local colors = {
  -- nightfoxで使用
  nightfox = '#172331',
  -- carbonfoxで使用
  carbonfox = '#161616',
  yellow = '#ffe64d',
  selected_blue = '#8080ff',
  blue = '#6fc3df',
  aliceblue = '#f0f8ff',
  peru = 'peru',
  white = '#ffffff'
}

-- テーマの上書きを行うための関数
local function theme_override_settings (theme_type)
  local base_theme = {
    -- 補完メニューのスクロールバーの色
    PmenuThumb = { bg = colors['white'] },
    -- 境界線の色
    VertSplit = { fg = colors['blue'] },
    -- 選択時の色: 視認性重視
    Visual = { fg = colors['white'], bg = colors['selected_blue'] },
  }

  -- coc.nvim
  local coc_theme = {
    -- 補完メニューのホバーしたときの色
    CocMenuSel = { bg = '#73daca', fg = 'bg0' },
    -- フローティングウィンドウの色
    CocFloating = { bg = '#002b36' }
  }

  -- タブの色を背景色と同化させる
  local tab_line = {
    nightfox = { bg = colors['nightfox'] },
    carbonfox = { bg = colors['carbonfoxk'] }
  }

  if theme_type == 'nightfox' then
    base_theme['CocMenuSel'] = coc_theme['CocMenuSel']
    base_theme['TabLineFill'] = tab_line['nightfox']
    -- フローティングウィンドウの色
    base_theme['NormalFloat'] = { bg = '#3b474a' }
  elseif theme_type == 'carbonfox' then
    base_theme['CocFloating'] = coc_theme['CocFloating']
    base_theme['TabLineFill'] = tab_line['carbonfox']
  end

  return base_theme
end

-- ファイルの最後でテーブルを返すことでモジュールとして扱えるようにする
THEME.theme_override_settings = theme_override_settings
THEME.colors = colors

return THEME
