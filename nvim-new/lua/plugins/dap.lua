local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

--[[ local dap_vscode_js_status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not dap_vscode_js_status_ok then
	return
end ]]

dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.api.nvim_set_hl(0, "blue",   { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "red",   { fg = "#BF616A" })
vim.api.nvim_set_hl(0, "green",  { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
vim.fn.sign_define('DapBreakpoint', {text='⚫', texthl='red', linehl='', numhl=''})
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

local path_status_ok, path = pcall(require, "mason-core.path")
if not path_status_ok then
	return
end

require('dap-vscode-js').setup({
  debugger_executable = '/Users/toakley/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
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
}
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

-- We need to wait for execution to stop at the first breakpoint before showing the UI to give the source maps time to generate.
-- If we don't, the UI will close because the source maps haven't generated in time.
dap.listeners.after.event_breakpoint["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
