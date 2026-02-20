-- tokyonight.lua — Color Scheme
-- Sets the Tokyo Night (night variant) color scheme.
-- Loads immediately at startup (priority 1000). No keymaps.
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight-night")
  end,

}
