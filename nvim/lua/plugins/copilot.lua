return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
    require('copilot').setup({
      panel = {
        enabled = true,
        auto_refresh = true, -- Let it search automatically when you open it
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<leader>cp" -- Use the leader key we discussed
        },
        layout = {
          position = "right",
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      -- Use default filetypes (most code files are enabled by default)
      filetypes = {
        ["*"] = true, -- This enables it for EVERYTHING; use with caution
      },
    })
    end,
    dependencies = {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end
    },
  }
}
