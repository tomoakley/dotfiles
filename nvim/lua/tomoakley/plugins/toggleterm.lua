return {
  "akinsho/toggleterm.nvim",
  tag = "v2.*",
  config = function ()
    return {
      open_mapping = '<leader>/',
      terminal_mappings = true,
      shade_terminals = true,
      shading_factor = 5,
      Normal = {
        guibg = 'NONE',
        ctermbg ="NONE"
      },
      direction = 'horizontal',
      persist_mode = false,
      highlights = {
        Normal = {
          link = "Normal",
        }
      }
    }
  end
}

-- local opts = {buffer = 0, silent = true}
-- vim.keymap.set('n', '<leader>/', ':ToggleTermToggleAll<CR>', opts)
-- vim.keymap.set('t', '<leader>/', ':ToggleTermToggleAll<CR>', opts)

