return {
  "leath-dub/snipe.nvim",
  config = function ()
    local snipe = require('snipe')
    snipe.setup({
      sort = "last",
      hints = {
        dictionary = "sadlewcmpghio"
      },
      navigate = {
        cancel_snipe = "f"
      }
    })
    vim.keymap.set("n", "<space>f", snipe.open_buffer_menu)

    snipe.ui_select_menu = require("snipe.menu"):new { position = "cursor" }
    snipe.ui_select_menu:add_new_buffer_callback(function (m)
      vim.keymap.set("n", "<esc>", function ()
        m:close()
      end, { nowait = true, buffer = m.buf })
      vim.keymap.set("n", "q", function ()
        m:close()
      end, { nowait = true, buffer = m.buf })
    end)
    vim.ui.select = snipe.ui_select;
  end
}
