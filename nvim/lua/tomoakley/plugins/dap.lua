return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "mxsdev/nvim-dap-vscode-js",
      branch = "start-debugging",
      build = "npm install --legacy-peer-deps && npx gulp dapDebugServer"
    }
  },
  config = function ()
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
            return
    end

    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
            return
    end

    dap.defaults.fallback.terminal_win_cmd = '20split new'
    vim.api.nvim_set_hl(0, "blue",   { fg = "#3d59a1" })
    vim.api.nvim_set_hl(0, "red",   { fg = "#BF616A" })
    vim.api.nvim_set_hl(0, "green",  { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
    vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    vim.fn.sign_define('DapStopped', { text='⧁', texthl='green',  linehl='DapBreakpoint', numhl='DapBreakpoint' })

    vim.keymap.set("n", 'd<leader>b', dap.toggle_breakpoint)
    vim.keymap.set("n", 'd<leader>c', dap.continue)
    vim.keymap.set("n", "d<leader>n", dap.step_over)
    vim.keymap.set("n", "d<leader>i", dap.step_into)
    vim.keymap.set("n", "d<leader>o", dap.step_out)
    vim.keymap.set("n", "d<leader>C", dap.clear_breakpoints)
    vim.keymap.set("n", "d<leader>k", dapui.eval)
    vim.keymap.set("n", "d<leader>t", dapui.toggle)
    --[[ ["<M-w>"] = dapui.elements.watches.add,
    ["<M-m>"] = dapui.float_element,
    ["<M-v>"] = function()
      dapui.float_element("scopes")
    end,
    ["<M-r>"] = function()
      dapui.float_element("repl")
    end, ]]

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>" },
        open = "o",
        remove = "d",
        edit = "e",
        toggle = "t",
        repl = "r",
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      layouts = {
        {
          elements = {
            'stacks',
            'breakpoints',
            'scopes',
          },
          size = 70,
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 10,
          position = 'bottom',
        },
      },
    })

    require('dap-vscode-js').setup({
      debugger_executable = '/Users/tomoakley/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      adapters = { 'pwa-node' },
    })

    for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          -- trace = true, -- include debugger info
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true
        },
        {
          name = "React native",
          type = "pwa-node",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          port = 35000,
        },
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}"
        }
    }
    end

    -- We need to wait for execution to stop at the first breakpoint before showing the UI to give the source maps time to generate.
    -- If we don't, the UI will close because the source maps haven't generated in time.

    local debug_win = nil
    local debug_tab = nil
    local debug_tabnr = nil

    -- open dap-ui in a tab
    local function open_in_tab()
      if debug_win and vim.api.nvim_win_is_valid(debug_win) then
        vim.api.nvim_set_current_win(debug_win)
        return
      end

      vim.cmd('tabedit %')
      debug_win = vim.fn.win_getid()
      debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
      debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

      dapui.open()
    end

    -- close dap-ui when debugger session ends and reset buffer numbers
    local function close_tab()
      dapui.close()

      if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
        vim.api.nvim_exec('tabclose ' .. debug_tabnr, false)
      end

      debug_win = nil
      debug_tab = nil
      debug_tabnr = nil
    end

    dap.listeners.after.event_breakpoint["dapui_config"] = function()
      open_in_tab()
    end

    dap.listeners.after.event_initialized['dapui_config'] = function()
      open_in_tab()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      close_tab()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      close_tab()
    end
  end
}
