-- floaterm.lua — Floating Terminal
-- Opens a floating terminal window inside Neovim.
-- Keymaps:
--   <leader>ft  Open a new floating terminal (60% height, 40% width)
return {
  "voldikss/vim-floaterm",
  config = function()
    vim.keymap.set("n", "<leader>ft", ':FloatermNew --height=0.6 --width=0.4 --name=floaterm1 --cwd=/home/s0001483/src<CR>', { desc = "Opens a new Floaterm windows" })
      end,
}
