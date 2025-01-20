return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin-mocha",
			},
			dependencies = {
				"nvim-tree/nvim-web-devicons",
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
