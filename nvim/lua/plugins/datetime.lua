return {
  {
    'AntonVanAssche/date-time-inserter.nvim',
    version = '*',
    lazy = false,
    config = function()
      local date_time_inserter = require("date-time-inserter")
      date_time_inserter.setup({
        date_format = 'DDMMYYYY',
        date_separator = '/',
        date_time_separator = ' @ ',
        time_format = 24,
        show_seconds = false
      })
      vim.keymap.set("n", "<leader>dt", ":InsertDate<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tt", ":InsertTime<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>dtt", ":InsertDateTime<CR>", { noremap = true, silent = true })
    end
  },
}

