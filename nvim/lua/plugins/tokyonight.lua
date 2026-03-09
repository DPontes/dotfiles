-- tokyonight.lua — Color Scheme
-- Sets the Tokyo Night (night variant) color scheme.
-- Loads immediately at startup (priority 1000). No keymaps.
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    on_highlights = function(hl, c)
      hl.LineNr = { fg = "#737aa2" }
      hl.LineNrAbove = { fg = "#737aa2" }
      hl.LineNrBelow = { fg = "#737aa2" }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,

}
