return {
  'ThePrimeagen/git-worktree.nvim',
  config = function ()
    local worktree = require('git-worktree')
    worktree.setup({
      change_directory_command = 'tcd',
      update_on_change_command = "tabnew | tcd .",
      --update_on_change_command = 'silent !tmux new-window -c .'
    })

    worktree.on_tree_change(function(op, metadata)
      if op == worktree.Operations.Switch then
          -- Send 'cd' command to all toggleterm terminals
          vim.cmd("TermExec cmd='cd ../" .. metadata.path .. "'")
      end
    end)
  end
}
