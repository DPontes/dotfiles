return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    on_colors = function(c)
      local p = require("palette")
      c.bg            = p.bg
      c.bg_dark       = p.bg_dark
      c.bg_highlight  = p.bg_highlight
      c.bg_popup      = p.bg_popup
      c.bg_search     = p.bg_search
      c.bg_sidebar    = p.bg_sidebar
      c.bg_statusline = p.bg_statusline
      c.bg_visual     = p.bg_visual
      c.fg            = p.fg
      c.fg_dark       = p.fg_dark
      c.fg_gutter     = p.fg_gutter
      c.dark3         = p.dark3
      c.dark5         = p.dark5
      c.blue          = p.blue
      c.blue1         = p.blue1
      c.blue2         = p.blue2
      c.blue5         = p.blue5
      c.blue6         = p.blue6
      c.blue7         = p.blue7
      c.cyan          = p.cyan
      c.teal          = p.teal
      c.green         = p.green
      c.green1        = p.green1
      c.green2        = p.green2
      c.red           = p.red
      c.red1          = p.red1
      c.orange        = p.orange
      c.yellow        = p.yellow
      c.magenta       = p.magenta
      c.magenta2      = p.magenta2
      c.purple        = p.purple
      c.pink          = p.pink
      c.comment       = p.comment
    end,
    on_highlights = function(hl, _)
      local p = require("palette")
      hl.LineNr      = { fg = p.fg_gutter }
      hl.LineNrAbove = { fg = p.fg_gutter }
      hl.LineNrBelow = { fg = p.fg_gutter }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
