-- plugins with no config
return {
  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "ThePrimeagen/git-worktree.nvim",

  -- Code formatting - not done
  "numToStr/Comment.nvim",
  "tpope/vim-surround",
  "nathanaelkane/vim-indent-guides",
  "kien/rainbow_parentheses.vim",
  "unblevable/quick-scope",

  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      'MunifTanjim/nui.nvim',
    }
  }
}
