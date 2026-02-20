-- telescope.lua — Fuzzy Finder & Picker
-- Fuzzy finding over files, text (grep), buffers, and help tags.
-- Also installs telescope-ui-select to replace vim.ui.select with a Telescope dropdown.
-- Keymaps:
--   <leader>fr  Reveal current file in Neo-tree sidebar
--   <leader>ff  Find files by name
--   <leader>fg  Live grep (search file contents)
--   <leader>fb  List open buffers
--   <leader>fh  Search help tags
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", { desc = "Telescope reveal file in Neotree" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
