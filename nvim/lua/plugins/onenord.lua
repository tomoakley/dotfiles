return {
  "rmehri01/onenord.nvim",
  config = function()
    require('onenord').setup({
      borders = false, -- Split window borders
      fade_nc = true -- fade non-active split
    })
  end
}

