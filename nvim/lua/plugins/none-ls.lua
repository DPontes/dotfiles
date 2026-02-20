-- none-ls.lua — Formatting (null-ls fork)
-- Provides code formatting via none-ls. Currently configured with stylua for Lua.
-- No keymaps — use <leader>gf (from lsp-config) or :lua vim.lsp.buf.format().
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
			},
		})
	end,
}
