vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.g.mapleader = " "

-- removes highlights
vim.keymap.set("n", "<leader>hh", ":noh<CR>", {})
