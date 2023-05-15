require('onenord').setup({
  borders = false, -- Split window borders
  fade_nc = true -- fade non-active split
})

require('lualine').setup({
  options = { theme = 'onenord' }
})
