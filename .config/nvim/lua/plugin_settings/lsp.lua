local mason_status, mason = pcall(require, 'mason')
local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local cmp_status, cmp = pcall(require, 'cmp')

if (not mason_status) and (not mason_lspconfig_status) and (not lspconfig_status) and (not cmp_nvim_lsp_status) and (not cmp_status) then return end

mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    -- languages
    'html',
    'cssls',
    'tsserver',
    'gopls',
    'lua_ls',
    -- libraries
    'svelte',
    -- FW
    'astro',
    'tailwindcss',
    -- others
    'jsonls',
    'dockerls',
    'yamlls'
  },
  automatic_installation = true,
}
mason_lspconfig.setup_handlers({ function(server)
  local opt = {
    capabilities = cmp_nvim_lsp.default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  lspconfig[server].setup(opt)
end })
-- LuaのLSPの設定をオーバーライドする
-- 参考: https://github.com/cpdean/cpd.dotfiles/blob/7da9ac7f64857cb5139f6623bd8ca0eaf63ddd5f/config/nvim/lua/cpdean_config/nvim-lsp.lua#L326-L375
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- vimというグローバル変数を認識させる
        globals = { 'vim' },
      },
      workspace = {
        -- Neovimのランタイムパス内のファイルをライブラリとして利用するようする
        library = vim.api.nvim_get_runtime_file('', true),
        -- サードパーティライブラリのチェックを無効化する
        checkThirdParty = false,
      },
      -- テレメトリ（統計情報）を無効に設定
      telemetry = {
        enable = false,
      },
    },
  },
})

-- キーマッピング
-- ヒントを表示
vim.keymap.set('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- 定義元ジャンプ
vim.keymap.set('n', '<space>]', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- カーソル下の変数をコード内で参照している箇所を一覧表示
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

-- 必要になったらコメントアウト解除して使えるようにする
-- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
-- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- LSP handlers
-- LSPサーバーから送信される"publishDiagnostics"メッセージを処理する際に、仮想テキストとしてエラー情報を表示しないようにする
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

--
-- Completion settings (hrsh7th/nvim-cmp)
--
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    -- スクロールのキーマッピング
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  }),
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = 'single'
    }),
    documentation = cmp.config.window.bordered({
      border = 'single'
   }),
  }
})
