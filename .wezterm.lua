-- NOTE: 関数を保護されたモードで呼び出すpcallを使って、weztermを呼び出す。
-- pcallの最初の戻り値がfalseの時は、funcの実行中にエラーが発生している。
--
-- http://www.rtpro.yamaha.co.jp/RT/docs/lua/tutorial/library.html#pcall
local status, wezterm = pcall(require, "wezterm")
if not status then
  return
end

-- os.dateによって返却された数値から曜日を判定し、漢字に変換する
-- (曜日, 1〜7, 日曜日が 1)
local function day_of_week_ja(w_num)
  if w_num == 1 then
    return "日"
  elseif w_num == 2 then
    return "月"
  elseif w_num == 3 then
    return "火"
  elseif w_num == 4 then
    return "水"
  elseif w_num == 5 then
    return "木"
  elseif w_num == 6 then
    return "金"
  elseif w_num == 7 then
    return "土"
  end
end

-- 年月日と時間、バッテリーの残量をステータスバーに表示する
-- ウィンドウが最初に表示されてから1秒後に開始され、1秒に1回トリガーされるイベント
wezterm.on("update-status", function(window, pane)
  -- 日付のtableを作成する方法じゃないと曜日の取得がうまくいかなかった
  -- NOTE: https://www.lua.org/pil/22.1.html
  local wday = os.date("*t").wday
  -- 指定子の後に半角スペースをつけないと正常に表示されなかった
  local wday_ja = string.format("(%s)", day_of_week_ja(wday))
  local date = wezterm.strftime("  📆 %Y-%m-%d " .. wday_ja .. "  ⏰ %H:%M:%S  ")

  local bat = ""

  for _, b in ipairs(wezterm.battery_info()) do
    local battery_state_of_charge = b.state_of_charge * 100
    local battery_icon = ""

    if battery_state_of_charge >= 80 then
      battery_icon = "🌕 "
    elseif battery_state_of_charge >= 70 then
      battery_icon = "🌖 "
    elseif battery_state_of_charge >= 60 then
      battery_icon = "🌖 "
    elseif battery_state_of_charge >= 50 then
      battery_icon = "🌗 "
    elseif battery_state_of_charge >= 40 then
      battery_icon = "🌗 "
    elseif battery_state_of_charge >= 30 then
      battery_icon = "🌘 "
    elseif battery_state_of_charge >= 20 then
      battery_icon = "🌘 "
    else
      battery_icon = "🌑 "
    end

    bat = string.format("%s%.0f%%", battery_icon, battery_state_of_charge)
  end

  window:set_right_status(wezterm.format({
    { Text = bat .. date },
  }))
end)

-- タブの表示をカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1

  if tab.is_active then
    -- Copy mode時
    if string.match(tab.active_pane.title, "Copy mode:") ~= nil then
      return string.format(" %d %s ", tab_index, "Copy mode...📄")
    end

    -- Zoom mode時
    if tab.active_pane.is_zoomed then
      return string.format(" %d %s ", tab_index, "Zoom mode...🔍")
    end
  end

  return string.format(" %d ", tab_index)
end)

-- 起動時にウィンドウをフルスクリーンにする
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

local theme = require("theme")
local selected_theme = theme.theme_config[theme.selected_theme]
local selected_theme_bg = selected_theme["bg"]
local wezterm_theme = selected_theme["wezterm"]

local colors = {
  cursor_fg = theme.colors["black"],
  cursor_bg = theme.colors["yellow"],
  -- split = theme.colors["blue"],
  -- the foreground color of selected text
  selection_fg = selected_theme_bg,
  -- the background color of selected text
  selection_bg = theme.colors["yellow"],
  tab_bar = {
    background = selected_theme_bg,
    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = theme.colors["aliceblue"],
      fg_color = selected_theme_bg,
    },
    -- plus button hidden
    new_tab = {
      bg_color = selected_theme_bg,
      fg_color = selected_theme_bg,
    },
  },
  quick_select_label_bg = { Color = theme.colors["peru"] },
  quick_select_label_fg = { Color = theme.colors["white"] },
}

-- キーバインドの設定、macOSの場合は以下のようになる
--
-- ALT → OPTION

-- leader keyを CTRL + qにマッピング
local leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
local act = wezterm.action
local keys = {
  -- CMD + cでタブを新規作成
  { key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
  -- CMD + xでタブを閉じる
  { key = "x", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },
  -- CTRL + q + numberでタブの切り替え
  { key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
  { key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
  { key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
  { key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
  { key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
  { key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
  { key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
  { key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
  { key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
  -- PANEを水平方向に開く
  { key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  -- PANEを縦方向に開く
  { key = "|", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  -- hjklでPANEを移動する
  { key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
  { key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
  { key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
  { key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
  -- タブを入れ替える
  { key = "{", mods = "LEADER", action = act({ MoveTabRelative = -1 }) },
  { key = "}", mods = "LEADER", action = act({ MoveTabRelative = 1 }) },
  -- PANEを閉じる
  { key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
  -- ALT + hjklでペインの幅を調整する
  { key = "h", mods = "ALT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
  { key = "j", mods = "ALT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
  { key = "k", mods = "ALT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
  { key = "l", mods = "ALT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
  -- QuickSelect・・・画面に表示されている文字をクイックにコピペできる機能
  { key = "Enter", mods = "SHIFT", action = "QuickSelect" },
  -- 画面の文字の大きさを調整する
  -- HINT: ⌘ + 0で文字の大きさをもとに戻す
  { key = "+", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  -- 画面上に表示されたアルファベットを使用して、特定のペインに移動する
  { key = "1", mods = "CTRL", action = act.PaneSelect },
  -- 画面上に表示されたアルファベットを使用して、現在のペインと選択したペインを入れ替える
  { key = "2", mods = "CTRL", action = act({ PaneSelect = { mode = "SwapWithActive" } }) },
  -- コマンドパレットを開く
  -- コマンドパレット経由でキーマッピングに設定していない機能も使うことができる
  { key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
  -- Zoomモードの切り替え
  { key = "Z", mods = "CTRL", action = act.TogglePaneZoomState },
}

return {
  color_scheme = wezterm_theme,
  default_cwd = os.getenv("HOME") .. "/Documents/",
  colors = colors,
  leader = leader,
  keys = keys,
  font_size = 15,
  font = wezterm.font("HackGen35 Console"),
  window_padding = { left = 10, right = 10, top = 10, bottom = 10 },
  line_height = 1.25,
  use_fancy_tab_bar = false,
  front_end = "WebGpu",
  -- アクティブではないペインの彩度を変更しない
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },
  -- ビープ音を無効にする
  audible_bell = "Disabled",
}
