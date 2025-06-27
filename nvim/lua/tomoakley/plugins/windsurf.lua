return {
   "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
            enable_cmp_source = true,
            virtual_text = {
                enabled = false,
                manual = false,
                key_bindings = {
                    -- Accept the current completion.
                    accept = "<Tab>",
                    -- Accept the next word.
                    accept_word = false,
                    -- Accept the next line.
                    accept_line = false,
                    -- Clear the virtual text.
                    clear = false,
                    -- Cycle to the next completion.
                    next = "<C-]>",
                    -- Cycle to the previous completion.
                    prev = "<C-[>",
                }
            }
        })
        -- vim.keymap.set("i", 'q', require('codeium.virtual_text').cycle_or_complete)
    end
}
