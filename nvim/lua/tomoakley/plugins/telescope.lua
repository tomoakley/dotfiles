return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      --"nvim-telescope/telescope-frecency.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim"
    },
    config = function ()
      local telescope = require('telescope')
      local telescopeBuiltIn = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local themes = require('telescope.themes')


      telescope.setup({
        pickers = {
          buffers = {
            mappings = {
              n = {
                ["<C-r>"] = require('telescope.actions').delete_buffer,
                ["<C-q>"] = function(bufnr)
                  actions.smart_send_to_qflist(bufnr)
                  telescopeBuiltIn.quickfix()
                end,
              },
              i = {
                ["<C-r>"] = actions.delete_buffer,
              }
            }
          },
          lsp_references = {
            theme = "dropdown"
          }
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
          },
          fzf = {
            ignore_current_buffer = true,
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          },
          ["ui-select"] = {
            themes.get_dropdown {
              -- even more opts
            }
          }
        },
        defaults = {
          file_ignore_patterns = {"ios/Pods", ".yarn/", ".git"},
          dynamic_preview_title = true,
          path_display = {"truncate"},
          layout_config = {
            prompt_position = "top"
         }
        },
      })
      telescope.load_extension('fzf')
      telescope.load_extension("file_browser")
      telescope.load_extension("git_worktree")
      telescope.load_extension("ui-select")
      --telescope.load_extension("frecency")
      --telescope.load_extension("circleci")
      --vnoremap <leader>gs "zy <cmd>Telescope live_grep default_text=<C-r>z<cr>

      vim.keymap.set('n', '<C-p>', function()
        telescopeBuiltIn.find_files({ hidden = true })
      end, {})
      vim.keymap.set('n', '<leader>b', function()
        telescopeBuiltIn.buffers(require('telescope.themes').get_dropdown{
          previewer = false,
          sort_lastused = true,
          ignore_current_buffer = true,
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<C-p>', function()
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local prompt = current_picker:_get_prompt()

              actions.close(prompt_bufnr)
              telescopeBuiltIn.find_files({ default_text = prompt })
              return true
            end)
            return true
          end
        })
      end, {})
      vim.keymap.set('n', '<leader>gg', telescopeBuiltIn.live_grep, {})
      vim.keymap.set('n', '<leader>gs', function()
        telescopeBuiltIn.grep_string(require('telescope.themes').get_cursor())
      end, {})
      --vim.keymap.set('n', '<C-p>', telescopeBuiltIn.git_files, {})
      vim.keymap.set('n', '<leader>ps', function()
        telescopeBuiltIn.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.api.nvim_set_keymap(
        "n",
        "<C-n>",
        ":Telescope file_browser<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gw",
        ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gwc",
        ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
        { noremap = true, silent = true }
      )
    end
  },
}
