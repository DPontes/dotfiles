-- distroupdate.lua — Distro Updater
-- Provides :DistroUpdate command to update your Neovim distro/config.
-- Lazy-loaded on VeryLazy event. No keymaps.
return {
  "Zeioth/distroupgrade.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  opts = {}
}
