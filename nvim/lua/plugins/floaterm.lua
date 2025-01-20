return {
  "voldikss/vim-floaterm",
  config = function()
    vim.keymap.set("n", "<leader>ft", ':FloatermNew --height=0.6 --width=0.4 --name=floaterm1 --cwd=/home/s0001483/src<CR>', { desc = "Opens a new Floaterm windows" })
      end,
}
