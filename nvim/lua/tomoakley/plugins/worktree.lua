return {
  'polarmutex/git-worktree.nvim',
  config = function ()
    local git_worktree = require("git-worktree")
    local config = require('git-worktree.config')
    local Hooks = require("git-worktree.hooks")

    config.change_directory_command = 'tcd'

    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
      vim.notify('Moved from ' .. prev_path .. ' to ' .. path)
      vim.cmd("TermExec cmd='cd " .. path .. "'")

      update_on_switch(path, prev_path)
    end)

    Hooks.register(Hooks.type.CREATE, function (path, prev_path)
      vim.cmd("silent !cp ../main/node_modules .")
      vim.cmd("silent !cp ../main/ios/Pods ./ios/Pods")
    end)

    Hooks.register(Hooks.type.DELETE, function()
      vim.cmd(config.update_on_change_command)
    end)

    -- https://github.com/psteinroe/dotfiles/blob/ff443c0dfb027d750aa457db1768272a36d453f7/nvim/lua/plugins/worktree.lua#L32
    local function telescope_git_worktree()
      local pickers = require "telescope.pickers"
      local finders = require "telescope.finders"
      local conf = require("telescope.config").values
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      -- Get list of worktrees
      local worktrees = vim.fn.systemlist "git worktree list"
      local results = {}

      for _, worktree in ipairs(worktrees) do
        local parts = vim.split(worktree, "%s+")
        if #parts >= 3 then
          table.insert(results, {
            path = parts[1],
            branch = parts[3]:gsub("[%[%]]", ""),
            line = worktree,
          })
        end
      end

      pickers
        .new({}, {
          prompt_title = "Git Worktrees",
          finder = finders.new_table {
            results = results,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.branch .. " → " .. entry.path,
                ordinal = entry.branch .. " " .. entry.path,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                git_worktree.switch_worktree(selection.value.path)
              end
            end)

            map("i", "<C-d>", function()
              local selection = action_state.get_selected_entry()
              if selection then
                local confirm = vim.fn.input("Delete worktree " .. selection.value.branch .. "? (y/N): ")
                if confirm:lower() == "y" then
                  actions.close(prompt_bufnr)
                  git_worktree.delete_worktree(selection.value.path)
                end
              end
            end)

            return true
          end,
        })
        :find()
    end

    local map = vim.keymap.set

    map('n', '<leader>ww', telescope_git_worktree, { noremap = true, silent = true })
    map('n', '<leader>wc', ':Telescope git_worktree create_git_worktree<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>wd", function()
      local worktree = vim.fn.input "Worktree to delete: "
      if worktree ~= "" then
        git_worktree.delete_worktree(worktree)
      end
    end, { desc = "Delete worktree" })
  end
}
