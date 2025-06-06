return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>c", ":Neotree<CR>", {})
		vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", { desc = "Telescope reveal file in Neotree" })
	end,
}
