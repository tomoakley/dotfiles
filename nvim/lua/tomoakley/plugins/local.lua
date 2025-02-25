return {
  --[[ {
    "idb",
    dir = "~/code/idb.nvim",
    config = function() end,
  }, {
    "circleci.nvim",
    dir = "~/code/nvim-circleci",
    config = function()
      return {
        lsp = {
          enable = true,
          config = {
            enable_yaml = true
          }
        }
      }

    end
  } ]]
}
