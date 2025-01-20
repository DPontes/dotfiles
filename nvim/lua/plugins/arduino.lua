return {
  {
    "stevearc/vim-arduino",
    lazy = false,
    config = function ()
      vim.g.arduino_serial_baud = 115200
    end,
  },
}
