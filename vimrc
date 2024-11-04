" .vimrc

" set leader key to ,
let mapleader = ","

" No compatibility
set nocompatible
set encoding=utf-8
set modelines=0

set lazyredraw
set nocursorcolumn
set noswapfile

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

""au VimEnter * RainbowParenthesesToggle

" Key mappings

" jj to throw you into normal mode from insert mode
inoremap jj <esc>
" jk to throw you into normal mode from insert mode
inoremap jk <esc>
" Disable arrow keys (hardcore)
map  <up> <nop>
imap <up> <nop>
map  <down> <nop>
imap <down> <nop>
map  <left> <nop>
imap <left> <nop>
map  <right> <nop>
imap <right> <nop>

" map ; to : for rapid commands etc
nnoremap ; :

" reslect text that was just pasted
nnoremap <leader>v V`]

" open .vimrc in a split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" set <Shift-t/T> to go forward/back between tabs
noremap <S-l> gt
noremap <S-h> gT

" set <Ctrl-l/h/j/k> to change pane
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
tnoremap <C-l> <Esc><C-W>l
tnoremap <C-h> <Esc><C-W>h
tnoremap <C-j> <Esc><C-W>j
tnoremap <C-k> <Esc><C-W>k

tnoremap <Esc> <C-\><C-n>
tnoremap <Esc><Esc> <C-\><C-n>:bw!<CR>

" use tab and shift tab to indent and de-indent code
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Switch between last two files
nnoremap <space><space> <C-^>

" mapping for copy to clipboard from yank
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

if !has('nvim')
  set ttymouse=xterm2
endif

highlight clear SignColumn
highlight link SignColumn CursorColumn

autocmd BufWritePre * :%s/\s\+$//e " remove trailing spaces on save

set nofoldenable

" hide tmux status bar when vim starts, show when vim extts
autocmd VimEnter * silent !tmux set status off
autocmd VimLeave * silent !tmux set status on

set clipboard=unnamed
map <C-r>c :source $MYVIMRC<CR>
