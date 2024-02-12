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
      vim.cmd([[
        execute("%s/></>\r</g | filetype indent on | setf xml | normal gg=G")
      ]])
    end)

    if not success then
      vim.notify("[xml format]" .. error_message, vim.log.levels.ERROR)
    end
  end,
})

-- Glowをvim上で実行する
nvim_create_user_command("Glow", function()
  vim.cmd([[
  if !executable('glow')
    call s:echo_err("not found glow command.")
  endif

  execute('vs | wincmd j | resize 100 | terminal glow')
]])
end, {})

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
