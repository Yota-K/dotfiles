local status, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

nvim_treesitter_configs.setup({
	ensure_installed = {
		"css",
		"fish",
		"go",
		"html",
		"javascript",
		"json",
		"lua",
		"php",
		"scss",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	highlight = {
		enable = true,
	},
	modules = {},
})
