-- alpha.lua — Dashboard / Start Screen
-- Shows a custom ASCII "ZENSEACT" banner on the Neovim start screen (startify theme).
-- No keymaps — displayed automatically when opening Neovim with no file argument.
return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		dashboard.section.header.val = {
			[[     _/_/_/_/_/  _/_/_/_/  _/      _/    _/_/_/  _/_/_/_/    _/_/      _/_/_/   _/_/_/_/_/ ]],
			[[          _/    _/        _/_/    _/  _/        _/        _/    _/  _/             _/      ]],
			[[       _/      _/_/_/    _/  _/  _/    _/_/    _/_/_/    _/_/_/_/  _/             _/       ]],
			[[    _/        _/        _/    _/_/        _/  _/        _/    _/  _/             _/        ]],
			[[ _/_/_/_/_/  _/_/_/_/  _/      _/  _/_/_/    _/_/_/_/  _/    _/    _/_/_/       _/         ]],
		}
		alpha.setup(dashboard.opts)
	end,
}
