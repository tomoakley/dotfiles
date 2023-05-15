vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  "rmehri01/onenord.nvim",

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },

  -- telescope
  "nvim-telescope/telescope.nvim",
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  "nvim-treesitter/nvim-treesitter-context",
  --"nvim-treesitter/playground"

  -- lsp
  "neovim/nvim-lspconfig",
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    "L3MON4D3/LuaSnip",
    tag = "v1.*",
    build = "make install_jsregexp"
  },
  "onsails/lspkind-nvim",

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "ThePrimeagen/git-worktree.nvim",
  {
    "ldelossa/gh.nvim",
    dependencies = { "ldelossa/litee.nvim" }
  },

  -- Code formatting
  "axelvc/template-string.nvim",
  "tpope/vim-surround",
  "nathanaelkane/vim-indent-guides",
  "kien/rainbow_parentheses.vim",
  "unblevable/quick-scope",
  "adelarsq/vim-matchit",
  "nathanaelkane/vim-indent-guides",
  "m4xshen/autoclose.nvim",
  "numToStr/Comment.nvim",
  {
    "yardnsm/vim-import-cost",
    build = "npm install --production"
  },

  -- testing
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-jest",

  -- dap
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "mxsdev/nvim-dap-vscode-js",

  -- other
  "sunaku/vim-dasht",
  "metakirby5/codi.vim",
  "nvim-orgmode/orgmode",
  {
    "akinsho/toggleterm.nvim",
    tag = "v2.*"
  },
  "bennypowers/nvim-regexplainer/",

})
