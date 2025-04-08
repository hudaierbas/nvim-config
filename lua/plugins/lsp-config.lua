return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- TSServer'ın formatlama yapmasını engelle
          --client.server_capabilities.diagnostic = false -- ESLint ile çakışmayı önle
          client.server_capabilities.publishDiagnosticsProvider = false -- ESLint ile çakışmayı önle

          client.config.settings = {
            tsserver = {
              watchOptions = {
                useFsEvents = true, -- Yalnızca fsEvents kullanarak dosya izlemeyi etkinleştir
              }
            }
          }
        end,
        init_options = {
          maxTsServerMemory = 4096,
          experimental = {
            enableProjectDiagnostics = false,
          },
        },
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      -- lspconfig.eslint.setup {
      --   settings = {
      --     run = "onSave"
      --   }
      -- }
      -- lspconfig.eslint.setup({
      --   on_attach = function(client)
      --     client.server_capabilities.documentFormattingProvider = false
      --     client.server_capabilities.codeActionProvider = false
      --     client.server_capabilities.diagnosticProvider = false -- varsa bunu da kapat
      --
      --     -- Eğer `diagnosticProvider` çalışmazsa, aşağıdaki gibi publishDiagnostics işlevini override edebilirsin:
      --     client.handlers["textDocument/publishDiagnostics"] = function() end
      --   end,
      -- })

      lspconfig.omnisharp.setup({
        cmd = { "omnisharp" },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      })


      -- LSP Hata Gösterimi ve Diagnostic Konfigürasyonu
      vim.diagnostic.config({
        virtual_text = false, -- Hataları inline olarak gösterme
        signs = true,         -- Sol sütunda hata işaretlerini göster
        update_in_insert = false,
        float = {
          border = "rounded",
          source = "always"
        }
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>ge', vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })
    end,
  },
}
