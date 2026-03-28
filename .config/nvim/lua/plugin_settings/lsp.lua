-- lsp
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      opts = {
        keymap = {
          preset = "none",
          ["<C-n>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          documentation = {
            auto_show = true,
            window = { border = "rounded" },
          },
          ghost_text = { enabled = true },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },
  },
  event = {
    "VimEnter",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local blink_cmp = require("blink.cmp")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local languages = {
      "cssls",
      "gopls",
      "html",
      "lua_ls",
      "ruby_lsp",
      "rust_analyzer",
      "solargraph", -- Rubyのコード補完、ドキュメントを提供してくれるLSP
      "ts_ls",
    }
    local libraries = {
      "prismals",
      "svelte",
    }
    local frameworks = {
      "astro",
      "tailwindcss",
    }
    local others = {
      "biome",
      "denols",
      "dockerls",
      "emmet_language_server",
      "eslint",
      "graphql",
      "jsonls",
      "nil_ls",
      "sqls",
      "terraformls",
      "yamlls",
    }

    local servers = vim.iter({ languages, libraries, frameworks, others }):flatten():totable()

    mason_lspconfig.setup({
      ensure_installed = servers,
      automatic_enable = true,
    })
    vim.lsp.enable(servers)

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
      capabilities = blink_cmp.get_lsp_capabilities()
    })

    -- ref: https://github.com/NickCao/flakes/blob/master/nixos/mainframe/nvim.lua
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        -- ヒントを表示
        vim.keymap.set("n", "<space>h", vim.lsp.buf.hover, opts)
        -- 定義元ジャンプ
        vim.keymap.set("n", "<space>]", vim.lsp.buf.definition, opts)
        -- カーソル下の変数をコード内で参照している箇所を一覧表示
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- エラーを表示
        vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
        -- エラーの発生箇所に移動
        vim.keymap.set("n", "e]", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "e[", vim.diagnostic.goto_prev, opts)

        -- 必要になったらコメントアウト解除して使えるようにする
        -- vim.keymap.set('n', 'gf', function() vim.lsp.buf.format({ async = true }) end, opts)
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
        -- vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
      end,
    })

  end,
}
