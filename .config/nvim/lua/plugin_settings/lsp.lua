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
    local lspconfig = require("lspconfig")
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
        "tsserver",
        "gopls",
        "lua_ls",
        -- libraries
        "svelte",
        -- FW
        "astro",
        "tailwindcss",
        -- others
        "jsonls",
        "dockerls",
        "yamlls",
        "denols",
        "eslint",
      },
      automatic_installation = true,
    })

    -- MasonToolsInstall
    mason_tool_installer.setup({
      ensure_installed = {
        "cspell",
      },
    })

    -- Denoのプロジェクトかどうかを判定する
    local function has_deno_files()
      local deno_files = { "deno.json", "deno.jsonc", "deps.ts", "import_map.json" }
      local root_dir = vim.fn.getcwd()

      for _, filename in ipairs(deno_files) do
        local target_file = root_dir .. "/" .. filename
        if vim.fn.findfile(target_file) == 1 then
          return true
        end
      end

      return false
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        -- Denoのプロジェクトかどうかを判定する
        -- TODO: lspconfigのroot_patternで対象ファイルが取得できないのでこの方法で判定している
        -- 現状だと、package.jsonが存在するディレクトリでないとLSPが起動しないので、
        local is_deno_repo = has_deno_files()

        local opts = {}
        opts.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        if server_name == "tsserver" then
          if is_deno_repo then
            return
          end
        elseif server_name == "denols" then
          if not is_deno_repo then
            return
          end

          opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
          opts.init_options = {
            enable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://crux.land"] = true,
                  ["https://deno.land"] = true,
                  ["https://x.nest.land"] = true,
                },
              },
            },
          }
        elseif server_name == "eslint" then
          opts.on_attach = function(buffer)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buffer,
            })
          end

        -- LuaのLSPの設定をオーバーライドする
        -- 参考: https://github.com/cpdean/cpd.dotfiles/blob/7da9ac7f64857cb5139f6623bd8ca0eaf63ddd5f/config/nvim/lua/cpdean_config/nvim-lsp.lua#L326-L375
        elseif server_name == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = {
                -- vimというグローバル変数を認識させる
                globals = { "vim" },
              },
              workspace = {
                -- Neovimのランタイムパス内のファイルをライブラリとして利用するようする
                library = vim.api.nvim_get_runtime_file("", true),
                -- サードパーティライブラリのチェックを無効化する
                checkThirdParty = false,
              },
              -- テレメトリ（統計情報）を無効に設定
              telemetry = {
                enable = false,
              },
            },
          }
        end

        opts.on_attach = function()
          -- キーマッピング
          -- ヒントを表示
          vim.keymap.set("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
          -- 定義元ジャンプ
          vim.keymap.set("n", "<space>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
          -- カーソル下の変数をコード内で参照している箇所を一覧表示
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
          -- エラーを表示
          vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")

          -- 必要になったらコメントアウト解除して使えるようにする
          -- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
          -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          -- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          -- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          -- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          -- vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          -- vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end

        lspconfig[server_name].setup(opts)
      end,
    })

    -- LSP handlers
    -- LSPサーバーから送信される"publishDiagnostics"メッセージを処理する際に、仮想テキストとしてエラー情報を表示しないようにする
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

    --
    -- Completion settings (hrsh7th/nvim-cmp)
    --
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
        completion = cmp.config.window.bordered({
          border = "single",
        }),
        documentation = cmp.config.window.bordered({
          border = "single",
        }),
      },
    })
  end,
}
