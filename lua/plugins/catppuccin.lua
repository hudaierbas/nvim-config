return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.surface0, blend = 10 },
        }
      end
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
