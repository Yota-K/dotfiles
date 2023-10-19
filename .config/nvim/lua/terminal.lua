local keyset = vim.api.nvim_set_keymap
local user_command = vim.api.nvim_create_user_command

-- TerminalをVSCodeのように現在のウィンドウの下に開く
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  command = "startinsert",
})

-- 常にインサートモードでTerminalを開く（水平分割）
user_command("T", "sp | wincmd j | resize 20 | terminal <args>", { nargs = "*" })
keyset("n", "T", ":T <cr>", { noremap = true })

-- 常にインサートモードでTerminalを開く（垂直分割）
user_command("TS", "vs | wincmd j | resize 100 | terminal <args>", { nargs = "*" })
keyset("n", "TS", ":TS <cr>", { noremap = true })

-- インサートモードからの離脱をspace + qにマッピング
keyset("t", "<Space>q", "<C-\\><C-n>", { silent = true })
