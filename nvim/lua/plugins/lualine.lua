return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local theme = {
      normal = {
        a = { bg = "#4A6B8A", fg = "#F1ECEC", gui = "bold" },
        b = { bg = "#2E2928", fg = "#C4BFBF" },
        c = { bg = "#1E1A19", fg = "#8E8888" },
      },
      insert = {
        a = { bg = "#5C7A9A", fg = "#F1ECEC", gui = "bold" },
        b = { bg = "#2E2928", fg = "#C4BFBF" },
        c = { bg = "#1E1A19", fg = "#8E8888" },
      },
      visual = {
        a = { bg = "#7A8FA0", fg = "#F1ECEC", gui = "bold" },
        b = { bg = "#2E2928", fg = "#C4BFBF" },
        c = { bg = "#1E1A19", fg = "#8E8888" },
      },
      replace = {
        a = { bg = "#8B5050", fg = "#F1ECEC", gui = "bold" },
        b = { bg = "#2E2928", fg = "#C4BFBF" },
        c = { bg = "#1E1A19", fg = "#8E8888" },
      },
      command = {
        a = { bg = "#8AADCA", fg = "#1E1A19", gui = "bold" },
        b = { bg = "#2E2928", fg = "#C4BFBF" },
        c = { bg = "#1E1A19", fg = "#8E8888" },
      },
      inactive = {
        a = { bg = "#1E1A19", fg = "#6A6464", gui = "bold" },
        b = { bg = "#1E1A19", fg = "#6A6464" },
        c = { bg = "#1E1A19", fg = "#6A6464" },
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
