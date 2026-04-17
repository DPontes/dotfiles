return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    on_colors = function(c)
      c.bg           = "#2A2524"
      c.bg_dark      = "#1E1A19"
      c.bg_highlight = "#3A3230"
      c.bg_popup     = "#332C2B"
      c.bg_search    = "#4A6B8A"
      c.bg_sidebar   = "#1E1A19"
      c.bg_statusline= "#1E1A19"
      c.bg_visual    = "#3D3635"
      c.fg           = "#F1ECEC"
      c.fg_dark      = "#C4BFBF"
      c.fg_gutter    = "#6A6464"
      c.dark3        = "#6A6464"
      c.dark5        = "#8E8888"
      c.blue         = "#8AADCA"
      c.blue1        = "#7A9AB5"
      c.blue2        = "#6A8AA5"
      c.blue5        = "#9AAFC0"
      c.blue6        = "#B0C4D4"
      c.blue7        = "#5C7A9A"
      c.cyan         = "#9AAFC0"
      c.teal         = "#7A9AB5"
      c.green        = "#8AADCA"
      c.green1       = "#9AAFC0"
      c.green2       = "#B0C4D4"
      c.red          = "#8B5050"
      c.red1         = "#7A4040"
      c.orange       = "#8B7050"
      c.yellow       = "#A09080"
      c.magenta      = "#9AAFC0"
      c.magenta2     = "#8AADCA"
      c.purple       = "#7A8FA0"
      c.pink         = "#B0C4D4"
      c.comment      = "#6A6464"
    end,
    on_highlights = function(hl, _)
      hl.LineNr      = { fg = "#6A6464" }
      hl.LineNrAbove = { fg = "#6A6464" }
      hl.LineNrBelow = { fg = "#6A6464" }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
