return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local p = require("palette")
    local theme = {
      normal = {
        a = { bg = p.mode_normal,  fg = p.fg,       gui = "bold" },
        b = { bg = p.surface_0,    fg = p.fg_dark },
        c = { bg = p.bg_dark,      fg = p.dark5 },
      },
      insert = {
        a = { bg = p.mode_insert,  fg = p.fg,       gui = "bold" },
        b = { bg = p.surface_0,    fg = p.fg_dark },
        c = { bg = p.bg_dark,      fg = p.dark5 },
      },
      visual = {
        a = { bg = p.mode_visual,  fg = p.fg,       gui = "bold" },
        b = { bg = p.surface_0,    fg = p.fg_dark },
        c = { bg = p.bg_dark,      fg = p.dark5 },
      },
      replace = {
        a = { bg = p.mode_replace, fg = p.fg,       gui = "bold" },
        b = { bg = p.surface_0,    fg = p.fg_dark },
        c = { bg = p.bg_dark,      fg = p.dark5 },
      },
      command = {
        a = { bg = p.mode_command, fg = p.mode_command_fg, gui = "bold" },
        b = { bg = p.surface_0,    fg = p.fg_dark },
        c = { bg = p.bg_dark,      fg = p.dark5 },
      },
      inactive = {
        a = { bg = p.bg_dark,      fg = p.fg_gutter, gui = "bold" },
        b = { bg = p.bg_dark,      fg = p.fg_gutter },
        c = { bg = p.bg_dark,      fg = p.fg_gutter },
      },
    }

    require("lualine").setup({
      options = {
        theme = theme,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        }
      }
    })
  end,
}
