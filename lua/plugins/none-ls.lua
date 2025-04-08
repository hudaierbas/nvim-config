return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim", -- eslint_d
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        --Lua
        null_ls.builtins.formatting.stylua,

        -- JS/TS with single quotes
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--single-quote" },
        }),
        require("none-ls.diagnostics.eslint_d"),

        -- C#
        null_ls.builtins.formatting.csharpier,

        --Python
        --null_ls.builtins.formatting.isort,
        --null_ls.builtins.formatting.black,
      }
    })
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end
}
