return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require('lualine')

      lualine.setup({
        options = { theme = 'onenord' }
        --[[ sections = {
          lualine_x = {
            {
              require("noice").api.status.message.get_hl,
              cond = require("noice").api.status.message.has,
            },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              color = { fg = "#ff9e64" },
            },
          },
        } --]]
      })

      vim.api.nvim_set_keymap("n", "<Leader>s", "", {
          callback = function()
              vim.opt.laststatus = 0
              local statusline = vim.o.statusline

              lualine.hide({
                  place = { "statusline" },
                  unhide = statusline == "" or statusline == "%#Normal#",
              })
          end,
      })
    end
}

