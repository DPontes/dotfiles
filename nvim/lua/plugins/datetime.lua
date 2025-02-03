return {
  {
    'AntonVanAssche/date-time-inserter.nvim',
    version = '*',
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>rd", ':r! date "+\\%d-\\%m-\\%Y" <CR>', {})
      vim.keymap.set("n", "<leader>rt", ':r! date "+\\%H:\\%M:\\%S" <CR>', {})
    end
  },
}

