-- treesitter.lua — Syntax Highlighting & Indentation
-- Tree-sitter powered syntax highlighting and smart indentation.
-- Auto-installs parsers for opened file types. Ensures json5 parser.
-- No keymaps — activates automatically on file open.
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = { "json5", "markdown", "markdown_inline", "bash", "python" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
