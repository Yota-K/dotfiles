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

-- xmlを整形
nvim_create_user_command("XmlFormatter", function()
  local success, error_message = pcall(function()
    vim.cmd([[ execute("%s/></>\r</g | filetype indent on | setf xml | normal gg=G") ]])
  end)

  if not success then
    vim.notify("[xml format]" .. error_message, vim.log.levels.ERROR)
  end
end, {})

-- Cspellのユーザー辞書に単語を追加する処理
nvim_create_user_command("CspellAppend", function(opts)
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

-- Ctopをfloating window内で実行するコマンド
nvim_create_user_command("Ctop", function()
  -- ctopコマンドが存在するかチェック
  if vim.fn.executable("ctop") == 0 then
    vim.notify("ctop command not found.", vim.log.levels.ERROR)
    return
  end

  -- バッファを作成
  local buf = vim.api.nvim_create_buf(false, true)

  -- ウィンドウのサイズを設定（画面の80%）
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  -- ウィンドウの位置を中央に設定
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- floating windowを作成
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "single",
  })

  -- バッファにctopを実行するターミナルを起動
  vim.fn.termopen("ctop", {
    on_exit = function()
      -- ctopが終了したら自動的にウィンドウを閉じる
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end)
    end,
  })

  -- ターミナルモードに入る
  vim.cmd("startinsert")
end, {})

-- LazyGitをfloating window内で実行するコマンド
nvim_create_user_command("LazyGit", function()
  -- lazygitコマンドが存在するかチェック
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("lazygit command not found.", vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "single",
  })

  -- バッファにlazygitを実行するターミナルを起動
  vim.fn.termopen("lazygit", {
    on_exit = function()
      -- lazygitが終了したら自動的にウィンドウを閉じる
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end)
    end,
  })

  -- ターミナルモードに入る
  vim.cmd("startinsert")
end, {})

-- AIアシスタントをターミナルで起動するコマンド
-- デフォだと、Copilot cliを使用する
nvim_create_user_command("AiHelp", function(opts)
  local buf = vim.api.nvim_get_current_buf()
  local file_path = vim.api.nvim_buf_get_name(buf)

  if file_path == "" then
    vim.notify("No file is opened.", vim.log.levels.WARN)
    return
  end

  -- mode引数をパースして使用するコマンドを決定
  local command = "copilot"
  if opts.args and opts.args:match("mode=cursor") then
    command = "cursor-agent"
  end
  if opts.args and opts.args:match("mode=gemini") then
    command = "gemini"
  end

  -- CLIモード: ターミナルを垂直分割で開く
  vim.cmd("vsplit")
  vim.cmd("wincmd r")
  vim.cmd("terminal " .. command)
end, {
  nargs = "?",
  complete = function(arg_lead)
    local candidates = { "mode=copilot", "mode=cursor", "mode=gemini" }
    if arg_lead == "" then
      return candidates
    end
    local matches = {}
    for _, candidate in ipairs(candidates) do
      if candidate:find(arg_lead, 1, true) == 1 then
        table.insert(matches, candidate)
      end
    end
    return matches
  end,
})

-- ヴィジュアルモードで選択したテキストをCopilotで処理する
local function copilot_transform_selection()
  -- 元のバッファとウィンドウを保存
  local original_buf = vim.api.nvim_get_current_buf()
  -- 選択範囲を取得
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local start_col = start_pos[3]
  local end_col = end_pos[3]

  -- 選択されたテキストを取得
  local lines = vim.api.nvim_buf_get_lines(original_buf, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end

  -- 1行の場合と複数行の場合で処理を分ける
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  local selected_text = table.concat(lines, "\n")

  -- floating windowの位置を選択範囲の近くに設定
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1] - start_line + 2
  local col = start_col

  -- 入力用のバッファを作成
  local input_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(input_buf, "buftype", "prompt")
  vim.api.nvim_buf_set_option(input_buf, "bufhidden", "wipe")

  -- ウィンドウのサイズ
  local width = math.min(60, vim.o.columns - 4)
  local height = 3

  -- ウィンドウの位置を調整（画面外に出ないように）
  if row + height > vim.o.lines then
    row = vim.o.lines - height - 2
  end
  if col + width > vim.o.columns then
    col = vim.o.columns - width - 2
  end

  -- floating windowを作成
  local win = vim.api.nvim_open_win(input_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = "  Copilot Transform (Ctrl+S to execute) ",
    title_pos = "center",
  })

  -- プレースホルダーテキストを設定
  vim.api.nvim_buf_set_lines(input_buf, 0, -1, false, { "Enter instruction here..." })

  -- Control+S で実行する処理
  local function execute_transform()
    local instruction_lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
    local instruction = table.concat(instruction_lines, "\n"):gsub("^Enter instruction here%...%s*", "")

    instruction = vim.trim(instruction)

    if instruction == "" or instruction == "Enter instruction here..." then
      vim.notify("Instruction is empty.", vim.log.levels.WARN)
      vim.api.nvim_win_close(win, true)
      return
    end

    -- バッファの内容を更新してから読み取り専用にする
    vim.api.nvim_buf_set_lines(input_buf, 0, -1, false, { "Processing with Copilot... 🧐" })
    vim.api.nvim_buf_set_option(input_buf, "modifiable", false)

    -- ウィンドウのタイトルを更新
    vim.api.nvim_win_set_config(win, {
      relative = "editor",
      width = math.min(60, vim.o.columns - 4),
      height = 3,
      col = col,
      row = row,
      style = "minimal",
      border = "rounded",
      title = " Processing... ",
      title_pos = "center",
    })

    -- copilot コマンドを使用
    local prompt_file = vim.fn.tempname()
    local temp_file = vim.fn.tempname()

    -- プロンプトをファイルに保存
    local f = io.open(prompt_file, "w")
    if f then
      f:write(string.format(
        "Instruction: %s\n\nOriginal text:\n%s\n\nProvide only the transformed text without any explanation.",
        instruction,
        selected_text))
      f:close()
    end

    local cmd = string.format('cat %s | copilot --allow-all-tools 2>/dev/null', prompt_file)

    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          -- 一時ファイルに出力を保存
          local out_f = io.open(temp_file, "a")
          if out_f then
            for _, line in ipairs(data) do
              out_f:write(line .. "\n")
            end
            out_f:close()
          end
        end
      end,
      on_exit = function(_, exit_code)
        vim.schedule(function()
          if exit_code == 0 then
            local result_file = io.open(temp_file, "r")
            if result_file then
              local result = result_file:read("*all")
              result_file:close()

              if result and result ~= "" then
                -- Copilotの出力から統計情報を除外
                local lines = vim.split(result, "\n")
                local result_lines = {}

                for _, line in ipairs(lines) do
                  -- 統計情報の開始を検出（空行の後に続く統計情報を除外）
                  if line:match("^Total usage") or line:match("^Total duration") or line:match("^Total code changes") or line:match("^Usage by model") then
                    break
                  end

                  table.insert(result_lines, line)
                end

                -- 先頭と末尾の空行を削除
                while #result_lines > 0 and result_lines[1] == "" do
                  table.remove(result_lines, 1)
                end
                while #result_lines > 0 and result_lines[#result_lines] == "" do
                  table.remove(result_lines)
                end

                -- コードブロックマーカー(```)を削除
                if #result_lines > 0 and result_lines[1]:match("^```") then
                  table.remove(result_lines, 1)
                end
                if #result_lines > 0 and result_lines[#result_lines]:match("^```") then
                  table.remove(result_lines)
                end

                if #result_lines > 0 then
                  -- 元のバッファに直接書き込む
                  vim.api.nvim_buf_set_lines(original_buf, start_line - 1, end_line, false, result_lines)
                  vim.notify("Text transformed successfully!", vim.log.levels.INFO)
                else
                  vim.notify("No result from Copilot.", vim.log.levels.WARN)
                end
              else
                vim.notify("No result from Copilot.", vim.log.levels.WARN)
              end
            end
          else
            vim.notify("Failed to get response from Copilot. Make sure 'copilot' command is installed.",
              vim.log.levels.ERROR)
          end

          -- 処理完了後にウィンドウを閉じる
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end

          -- 一時ファイルを削除
          vim.fn.delete(prompt_file)
          vim.fn.delete(temp_file)
        end)
      end,
    })
  end

  -- キーマッピングを設定
  vim.keymap.set("i", "<C-s>", execute_transform, { buffer = input_buf, noremap = true, silent = true })
  vim.keymap.set("n", "<C-s>", execute_transform, { buffer = input_buf, noremap = true, silent = true })

  -- ESCで閉じる
  vim.keymap.set({ "i", "n" }, "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = input_buf, noremap = true, silent = true })

  vim.cmd("startinsert")
end

-- ヴィジュアルモードコマンドを作成
nvim_create_user_command("CopilotTransform", copilot_transform_selection, { range = true })

-- ヴィジュアルモードでa + eのキーマッピングを設定
vim.keymap.set("v", "ae", ":<C-u>CopilotTransform<CR>",
  { noremap = true, silent = true, desc = "Transform selection with Copilot" })
