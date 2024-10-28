return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require('neotest-jest')({
          --jestCommand = "jest --watch ",
        }),
      },
      quickfix = {
        open = false,
      },
    })

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "t<C-n>", neotest.run.run, bufopts)
    vim.keymap.set("n", "t<C-f>", neotest.run.run, bufopts)
    vim.keymap.set("n", "t<C-k>", neotest.output.open, bufopts)
    vim.keymap.set("n", "t[t", function() neotest.jump.next({ status = 'failed' }) end)
    vim.keymap.set("n", "t]t", function() neotest.jump.prev({ status = 'failed' }) end)
    vim.keymap.set("n", "t<C-d>", function()
      neotest.run.run({ strategy = 'dap' })
    end, bufopts)
  end
}
