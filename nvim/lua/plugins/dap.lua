return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    -- Basic debugging
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    
    -- DAP UI
    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    
    -- Enable DAP logging for troubleshooting
    dap.set_log_level('TRACE')
    
    -- Function to check if file has debug symbols
    local function check_debug_symbols(file_path)
      local handle = io.popen("file " .. file_path)
      local result = handle:read("*a")
      handle:close()
      print("Debug symbols check:", result)
      return result:find("not stripped") ~= nil
    end
    
    -- Setup DAP UI
    dapui.setup({
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      icons = { expanded = "", collapsed = "", current_frame = "" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      element_mappings = {},
      controls = {
        enabled = vim.fn.exists("+winbar") == 1,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = vim.g.border_chars or "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      },
    })
    
    -- Setup virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })
    
    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
    
    -- Configure C++ debugger adapters
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "gdb",
      args = { "--quiet", "--interpreter=dap" },
    }
    
    -- CodeLLDB adapter (recommended for C++)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }
    
    -- LLDB adapter (alternative)
    dap.adapters.lldb = {
      type = "executable",
      command = "lldb-vscode", -- or lldb-dap depending on your installation
      name = "lldb"
    }
    
    -- Configuration for C++ debugging
    dap.configurations.cpp = {
      {
        name = "Launch with GDB (fallback)",
        type = "cppdbg",
        request = "launch",
        program = function()
          local program_path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          if vim.fn.filereadable(program_path) == 0 then
            print("Error: File not found: " .. program_path)
            return nil
          end
          return program_path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        setupCommands = {
          {
            description = "Enable pretty-printing for gdb",
            text = "-enable-pretty-printing",
            ignoreFailures = true,
          },
        },
      },
        name = "Launch file",
        type = "codelldb", -- or "cppdbg" or "lldb"
        request = "launch",
        program = function()
          local program_path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          -- Convert to absolute path
          program_path = vim.fn.fnamemodify(program_path, ":p")
          -- Check if file exists and has debug symbols
          if vim.fn.filereadable(program_path) == 0 then
            print("Error: File not found or not readable: " .. program_path)
            return nil
          end
          check_debug_symbols(program_path)
          return program_path
        end,
        cwd = vim.fn.getcwd(), -- Use absolute current working directory
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        -- Add more verbose logging
        console = "integratedTerminal",
        logging = {
          engineLogging = true,
          trace = true,
          traceResponse = true,
        },
        -- Add source path mapping
        sourceMap = {
          ["/proc/self/cwd"] = vim.fn.getcwd(),
        },
        -- Alternative: use sourceFileMap for CodeLLDB
        sourceFileMap = {
          ["/proc/self/cwd"] = vim.fn.getcwd(),
        },
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "attach",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      },
    }
    
    -- Same configurations for C
    dap.configurations.c = dap.configurations.cpp
    
    -- Rust configuration (bonus)
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }
    
    -- Set breakpoint signs
    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "👉", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
  end,
}

