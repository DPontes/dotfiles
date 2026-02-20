-- git_tools.lua — Git Integration
-- Git gutter signs (additions, changes, deletions) via gitsigns.
-- Full Git commands via vim-fugitive (:Git, :Gblame, etc.).
-- Keymaps:
--   <leader>gp  Preview git hunk diff
--   <leader>gb  Toggle inline git blame
return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
  {
    "tpope/vim-fugitive",
  },
}
