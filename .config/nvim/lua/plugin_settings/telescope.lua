local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		color_devicons = true,
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		live_grep = {
			additional_args = function(opts)
				return { "--hidden" }
			end,
		},
	},
})

local keyset = vim.keymap.set

-- ファイル名で検索
keyset("n", "ff", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)

-- ファイルに含まれる文字列で検索
keyset("n", "fg", builtin.live_grep, {})

-- neovimで開いているバッファで検索
keyset("n", "fb", builtin.buffers, {})

-- helpを開く
keyset("n", "fh", builtin.help_tags, {})
