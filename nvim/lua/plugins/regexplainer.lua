return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'MunifTanjim/nui.nvim',
  },
  config = function ()
    vim.keymap.set('n', '<esc>', '<cmd>RegexplainerHide<cr>')
    return {
        mappings = {
          toggle = '<leader>gr',
          show = 'gS',
          hide = 'gH',
          show_split = 'gP',
          show_popup = 'gU',
        },
    }
  end
}
