-- luarocks.lua — Luarocks Integration
-- Ensures luarocks packages are available to Neovim plugins that depend on them.
-- Must load first (priority 1000). No keymaps.
return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
}
