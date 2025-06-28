-- lsp
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/vim-vsnip",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = {
    "VimEnter",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local cmp = require("cmp")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        -- languages
        "html",
        "cssls",
        "ts_ls",
        "gopls",
        "lua_ls",
        "ruby_lsp",
        "rust_analyzer",
        -- libraries
        "svelte",
        "prismals",
        -- FW
        "astro",
        "tailwindcss",
        -- others
        "jsonls",
        "dockerls",
        "yamlls",
        "denols",
        "eslint",
        "biome",
        "graphql",
        "nil_ls",
        "sqls",
        -- Rubyのコード補完、ドキュメントを提供してくれるLSP
        "solargraph",
        "terraformls",
      },
      automatic_enable = true,
    })

    -- MasonToolsInstall
    mason_tool_installer.setup({
      ensure_installed = {
        "biome",
        "cspell",
        "eslint_d",
        "prettier"
      },
    })

    vim.lsp.config("*", {
      on_attach = function(_, bufnr)
        -- キーマッピング
        -- ヒントを表示
        vim.keymap.set("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
        -- 定義元ジャンプ
        vim.keymap.set("n", "<space>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
        -- カーソル下の変数をコード内で参照している箇所を一覧表示
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
        -- エラーを表示
        vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
        -- エラーの発生箇所に移動
        vim.keymap.set("n", "e]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
        vim.keymap.set("n", "e[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

        -- 必要になったらコメントアウト解除して使えるようにする
        -- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
        -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
        -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        -- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        -- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        -- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      end,
      capabilities = cmp_nvim_lsp.default_capabilities()
    })

    -- 補完設定
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
      },
      mapping = cmp.mapping.preset.insert({
        -- スクロールのキーマッピング
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- enterで補完を確定する
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      experimental = {
        ghost_text = true,
      },
      window = {
        completion = {
          -- borderを非表示にする
          border = { "", "", "", "", "", "", "", "" },
          winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder",
        },
      },
    })
  end,
}
