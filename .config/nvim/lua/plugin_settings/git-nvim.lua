local status, git = pcall(require, "git")
if not status then
	return
end

git.setup({
	keymaps = {
		diff = "<Space>g",
		-- vim上でgit blame
		blame = "<Space>gb",
		-- 開いているコードをgitのリポジトリーで開く:w
		browse = "<Space>go",
	},
})

