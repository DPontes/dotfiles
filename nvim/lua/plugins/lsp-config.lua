return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
      }
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "jsonls", "pyright" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config.servers = {
        lua_ls = {
          capabilities = capabilities
        },
        clangd = {
          capabilities = capabilities
        },
        pyright = {
          capabilities = capabilities
        },
        jsonls = {
          capabilities = capabilities
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        callback = function()
          vim.bo.shiftwidth = 4 -- Set to 2 spaces per tab (change as needed)
          vim.bo.tabstop = 2
          vim.bo.expandtab = true
        end,
      })

      -- in :h vim.lsp.buf are all the available configurations for key-bindings for lspconfig
      vim.g.mapleader = " "
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, {})
      vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, {})
      vim.keymap.set('n', '<leader>gw', vim.lsp.buf.document_symbol, {})
      vim.keymap.set('n', '<leader>gW', vim.lsp.buf.workspace_symbol, {})
      vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, {})
      vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, {})
      vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, {})
    end,
  },
}
