-- neotree.lua — File Tree Explorer
-- Sidebar file explorer for navigating and managing files/directories.
-- Keymaps:
--   <leader>fr  Reveal current file in Neo-tree
-- Commands: :Neotree to open, j/k to navigate, <CR> to open files.
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", { desc = "Telescope reveal file in Neotree" })
	end,
}
