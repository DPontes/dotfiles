-- none-ls.lua — Formatting (null-ls fork)
-- Provides code formatting via none-ls.
-- mason-null-ls bridges Mason-installed tools into none-ls,
-- since Mason installs to its own bin dir which is not on the system PATH.
-- No keymaps — use <leader>gf (from lsp-config) or :lua vim.lsp.buf.format().
return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "black" },
			})
		end,
	},
}
