return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { "<leader>zz", function() require("CopilotChat").toggle() end, desc = "Toggle CopilotChat", mode = { "n", "v" } },
      { "<leader>ze", function() require("CopilotChat").ask("Explain this code") end, desc = "Explain code", mode = { "n", "v" } },
      { "<leader>zr", function() require("CopilotChat").ask("Review this code for bugs and improvements") end, desc = "Review code", mode = { "n", "v" } },
      { "<leader>zf", function() require("CopilotChat").ask("Fix this code") end, desc = "Fix code", mode = { "n", "v" } },
      { "<leader>zo", function() require("CopilotChat").ask("Optimize this code") end, desc = "Optimize code", mode = { "n", "v" } },
      { "<leader>zd", function() require("CopilotChat").ask("Add documentation/comments to this code") end, desc = "Add documentation", mode = { "n", "v" } },
      { "<leader>zt", function() require("CopilotChat").ask("Write tests for this code") end, desc = "Write tests", mode = { "n", "v" } },
      { "<leader>zc", function() require("CopilotChat").ask("Complete this code") end, desc = "Complete code", mode = { "n", "v" } },
      { "<leader>zq", function() require("CopilotChat").ask() end, desc = "Ask custom question", mode = { "n", "v" } },
      { "<leader>zn", function() require("CopilotChat").new() end, desc = "New chat", mode = { "n" } },
      { "<leader>zl", function() require("CopilotChat").list() end, desc = "List chats", mode = { "n" } },
      { "<leader>zs", function() require("CopilotChat").save() end, desc = "Save chat", mode = { "n" } },
    },
  },
}
