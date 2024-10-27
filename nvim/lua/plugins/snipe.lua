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
  end
}
