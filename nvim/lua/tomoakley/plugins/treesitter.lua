local treesitter_plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require('nvim-treesitter.configs')

      local opt = vim.opt
      opt.foldmethod = "expr"
      opt.foldexpr = "nvim_treesitter#foldexpr()"

      configs.setup {
          highlight = {
              enable = true,
              additional_vim_regex_highlighting = {'org'},
          },
          sync_install = true,
          incremental_selection = {
              enable = false,
          },
          indent = {
            enable = true
          },
          ensure_installed = {'javascript', 'typescript', 'tsx', 'lua', 'vim'},
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
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local context = require('treesitter-context')
      context.setup {
        enable = true
      }
      --[[ vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
        callback = function()
          if context.enabled() then
            context.disable()
            context.enable()
          end
        end,
      }) ]]
    end
  }
}


return treesitter_plugins
