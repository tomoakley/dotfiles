require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'},
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
      enable = true
    },
    ensure_installed = {'javascript', 'typescript', 'tsx', 'org', 'lua', 'vim', 'help'},
    playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_server_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

require'treesitter-context'.setup {
  enable = true
}

require('template-string').setup({
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
  jsx_brackets = true, -- should add brackets to jsx attributes
})

require('regexplainer').setup({
  mappings = {
    toggle = '<leader>gr',
    show = 'gS',
    hide = 'gH',
    show_split = 'gP',
    show_popup = 'gU',
  },
})
vim.keymap.set('n', '<esc>', '<cmd>RegexplainerHide<cr>')

require('Comment').setup()

require("autoclose").setup({
  options = {
    disabled_filetypes = { "text", "markdown" },
  },
})
