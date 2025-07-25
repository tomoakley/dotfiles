vim.cmd([[
  set nocompatible
  set encoding=utf-8
  set modelines=0

  set lazyredraw
  set nocursorcolumn
  set noswapfile
]])


vim.cmd([[
  " Enable Syntax highlighting
  syntax on
  syntax enable
  set termguicolors

  " Detect filetype
  filetype plugin on

  " Set relevant filetypes
  au BufRead,BufNewFile *.scss set filetype=scss
  au BufRead,BufNewFile *.md set filetype=markdown

  " Tabs, indentation and lines
  filetype plugin indent on
  " 2 spaces please
  set expandtab
  set shiftwidth=2
  set softtabstop=2

  set autoindent
  set smartindent

  let g:indentLine_char = '┊'
  nnoremap <leader>il :IndentGuidesToggle<CR>

  set mouse=

  " Start scrolling slightly before the cursor reaches an edge
  set scrolloff=3
  set sidescrolloff=5
  " Scroll sideways a character at a time, rather than a screen at a time
  set sidescroll=1
  " Allow motions and back-spacing over line-endings etc
  set backspace=indent,eol,start
  set whichwrap=h,l,b,<,>,~,[,]
  " Underscores denote words
  set iskeyword-=_

  " Show status line
  set laststatus=2
  " Hide the current working mode, as Lualine is installed
  set noshowmode
  " Show what commands you’re typing
  set showcmd
  " Allow modelines
  set modeline
  " Show current line and column position in file
  set ruler
  " Show file title in terminal tab
  set title
  set cmdheight=0

  " Set relative line numbers if we can...
  if exists("+relativenumber")
      " Due to a problem with relative line numbers not persisting across new
      " tabs and splits, set no line numbers at all...
      set nonumber
      " ..then set relative ones.
      set relativenumber
  endif
  " ...otherwise let’s just have regular ones.
  " Also sets current line to absolute in relative mode
  set number

  " Limit line-length to 80 columns by highlighting col 81 onward
  "if exists("+colorcolumn")
     " set colorcolumn=81
  "endif
  " Highlight current line
  set cursorline
  " Don’t keep results highlighted after searching...
  set nohlsearch
  " ...just highlight as we type
  set incsearch
  " Ignore case when searching...
  set ignorecase
  " ...except if we input a capital letter
  set smartcase
  " set guifont=inconsolata-dz:h14
  "set guifont=Fira\ Code:h16
  set guifont=FuraCode\ Nerd\ Font:h16

  " save on loosing focus
  au FocusLost * silent! update

  " only activate quickscope highlights on t/T/f/F
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
]])

-- misc settings
vim.cmd([[
  if !has('nvim')
    set ttymouse=xterm2
  endif

  highlight clear SignColumn
  highlight link SignColumn CursorColumn

  " remove trailing spaces on save
  autocmd BufWritePre * :%s/\s\+$//e

  set nofoldenable

  " hide tmux status bar when vim starts, show when vim extts
  autocmd VimEnter * silent !tmux set status off
  autocmd VimLeave * silent !tmux set status on

  " y(ank) in n(vim) will copy to clipboard and p(ut) will paste
  set clipboard=unnamed
]])
