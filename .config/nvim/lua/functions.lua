local nvim_create_user_command = vim.api.nvim_create_user_command

-- jqをVim上で実行
nvim_create_user_command("JsonFormatter", function()
  vim.cmd([[
    if !executable('jq')
      call s:echo_err("not found jq command.")
    endif

    execute("%!jq '.'")
  ]])
end, {})

-- xmlを保存時に整形
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.xml" },
  callback = function()
    local success, error_message = pcall(function()
      vim.cmd([[ execute("%s/></>\r</g | filetype indent on | setf xml | normal gg=G") ]])
    end)

    if not success then
      vim.notify("[xml format]" .. error_message, vim.log.levels.ERROR)
    end
  end,
})

-- タブラインのカスタマイズ
-- タブをタブ番号 + ファイル名 + ファイル拡張子のアイコンの形式に変更する
local fn = vim.fn
local function myTabline()
  local s = ""

  for i = 1, fn.tabpagenr("$") do
    local winnr = fn.tabpagewinnr(i)
    local buflist = fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local bufname = fn.bufname(bufnr)

    s = s .. "%" .. i .. "T"
    if i == fn.tabpagenr() then
      -- アクティブなタブページのラベル
      s = s .. "%#TabLineSel#"
    else
      -- アクティブでないタブページのラベル
      s = s .. "%#TabLine#"
    end

    -- Show tabnumber
    local tabnumber = string.format("[%s]", i)
    s = s .. tabnumber .. " "

    -- Show icon
    local icon = ""
    icon = vim.api.nvim_call_function("WebDevIconsGetFileTypeSymbol", { bufname }) .. " "

    -- bufname
    if bufname ~= "" then
      -- ファイル名の最後にあるセミコロンと$がついている場合は削除
      local match_pattern = "%;%$"
      if string.find(bufname, match_pattern) then
        bufname = string.gsub(bufname, match_pattern, "")
      end

      if icon ~= "" then
        s = string.format("%s%s%s%s", s, icon, fn.fnamemodify(bufname, ":t"), " ")
      else
        s = string.format("%s%s%s", s, fn.fnamemodify(bufname, ":t"), " ")
      end
    else
      s = s .. "No Name" .. " "
    end
  end

  -- タブページの行のラベルがない部分
  s = s .. "%#TabLineFill#"

  return s
end

-- グローバルな関数として登録
_G.myTabline = myTabline
vim.o.tabline = "%!v:lua.myTabline()"

-- Cspellのユーザー辞書に単語を追加する処理
vim.api.nvim_create_user_command("CspellAppend", function(opts)
  -- optsから引数を取得
  local word = opts.args or ""

  -- optsが空の場合はホバーしているワードを取得
  if word == "" then
    word = vim.fn.expand("<cword>"):lower()
  end

  -- 引数も設定せず、ホバーしているワードも取得できない場合はエラーを表示
  if word == "" then
    vim.notify("Word not set.", vim.log.levels.ERROR)
  end

  -- vim.call("expand", ...) を使用して、~をユーザーのホームディレクトリの絶対パスに展開する
  local cspell_dirs = {
    dotfiles = vim.call("expand", "~/.config/cspell/dotfiles.txt"),
    user = vim.call("expand", "~/.local/share/cspell/user.txt"),
  }

  -- bangの有無で保存先を分岐
  -- bang: コマンド実行時の!のこと
  -- CspellAppend! で実行すると、dotfiles.txtに追加する
  local dictionary_name = opts.bang and "dotfiles" or "user"

  -- shellのechoコマンドで登録したい単語を辞書ファイルに追加
  vim.fn.system(string.format("echo %s >> %s", word, cspell_dirs[dictionary_name]))

  -- cspellをリロードするため、現在行を更新してすぐ戻す
  if vim.api.nvim_get_option_value("modifiable", {}) then
    vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
    vim.api.nvim_command("silent! undo")
  end

  vim.notify(word .. " added to " .. dictionary_name .. " dictionary.", vim.log.levels.INFO)
end, {
  nargs = "?",
  bang = true,
})
