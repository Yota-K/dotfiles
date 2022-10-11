local wezterm = require 'wezterm';

-- ウィンドウが最初に表示されてから1秒後に開始され、1秒に1回トリガーされるイベントを定義
wezterm.on('update-right-status', function(window, pane)
  local success, date, stderr = wezterm.run_child_process({'date'});

  -- However, if all you need is to format the date/time, then:
  date = wezterm.strftime('📆 %Y-%m-%d (%a)  ⏰ %H:%M:%S ');
  window:set_right_status(wezterm.format({
    {Text=date},
  }));
end);

local base_colors = {
  black = '#1c1c1c',
  blue = '#6fc3df',
  secondary_blue = '#6871ff',
  light_red = '#ff6d67',
  tab_active_bg_blue = 'aliceblue',
  yellow = '#ffe64d'
}

local colors = {
  background = base_colors['black'],
  cursor_bg = base_colors['yellow'],
  split = base_colors['blue'],
  ansi = {
    'black',
    'maroon',
    'green',
    -- 今いるブランチのテキストの色
    base_colors['yellow'],
    -- ディレクトリとかの色
    base_colors['blue'],
    'purple',
    'teal',
    'silver',
  },
  -- 多分明度: アイコンフォントの色みがここで変更できる
  brights = {
    'grey',
    base_colors['light_red'],
    'lime',
    base_colors['yellow'],
    base_colors['secondary_blue'],
    'fuchsia',
    'aqua',
    'white',
  },
  tab_bar = {
    background = base_colors['black'],
    -- The active tab is the one that has focus in the window
    active_tab = {
      -- activeなタブの背景色を変更する
      bg_color = base_colors['tab_active_bg_blue'],
      fg_color = base_colors['black'],
    },
  },
}

-- キーバインドの設定

-- macの場合は以下のようになる
-- CTRL・・・CMD
-- ALT・・・OPTION
local act = wezterm.action;

-- leader keyを CTRL + qにマッピング
local leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 };

local keys = {
  -- CMD + cでタブを新規作成
  { key = 'c', mods = 'LEADER', action = act({ SpawnTab = 'CurrentPaneDomain' })},
  -- CMD + xでタブを閉じる
  { key = 'x', mods = 'LEADER', action = act({ CloseCurrentTab = { confirm = false } })},
  -- CTRL + q + numberでタブの切り替え
  { key = '1', mods = 'LEADER', action = act({ ActivateTab = 0 })},
  { key = '2', mods = 'LEADER', action = act({ ActivateTab = 1 })},
  { key = '3', mods = 'LEADER', action = act({ ActivateTab = 2 })},
  { key = '4', mods = 'LEADER', action = act({ ActivateTab = 3 })},
  { key = '5', mods = 'LEADER', action = act({ ActivateTab = 4 })},
  { key = '6', mods = 'LEADER', action = act({ ActivateTab = 5 })},
  { key = '7', mods = 'LEADER', action = act({ ActivateTab = 6 })},
  { key = '8', mods = 'LEADER', action = act({ ActivateTab = 7 })},
  { key = '9', mods = 'LEADER', action = act({ ActivateTab = 8 })},
  -- PANEを水平方向に開く
	{ key = '-', mods = 'LEADER', action = act({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
  -- PANEを縦方向に開く
	{ key = '|', mods = 'LEADER', action = act({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },
  -- hjklでPANEを移動する
	{ key = 'h', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Left' }) },
	{ key = 'l', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Right' }) },
	{ key = 'k', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Up' }) },
	{ key = 'j', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Down' }) },
  -- PANEを閉じる
  { key = 'x', mods = 'CTRL', action = act({ CloseCurrentPane = { confirm = false } }) },
  -- ALT + hjklでペインの幅を調整する
	{ key = 'h', mods = 'ALT', action = act({ AdjustPaneSize = { 'Left', 5 } }) },
	{ key = 'l', mods = 'ALT', action = act({ AdjustPaneSize = { 'Right', 5 } }) },
	{ key = 'k', mods = 'ALT', action = act({ AdjustPaneSize = { 'Up', 5 } }) },
	{ key = 'j', mods = 'ALT', action = act({ AdjustPaneSize = { 'Down', 5 } }) },
  -- { key = "Enter", mods = "ALT", action = "QuickSelect" },
		-- -- move cursor
		-- { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		-- { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		-- { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		-- { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		-- { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		-- { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		-- { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		-- { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
}

return {
  color_scheme = 'PaperColorDark (Gogh)',
  colors = colors,
  use_fancy_tab_bar = false,
  font_size = 16.5,
  font = wezterm.font('Ricty Diminished', { weight='Bold' }),
  line_height = 1.2,
  leader = leader,
  keys = keys
}
