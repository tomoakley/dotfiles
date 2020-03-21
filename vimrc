" .vimrc

" set leader key to ,
let mapleader = ","

" No compatibility
set nocompatible
set encoding=utf-8
set modelines=0

set ruler
set cursorline
"set number
syntax on
set lazyredraw
set nocursorcolumn
set noswapfile

" Plugins, managed by vim-plug
call plug#begin('~/.vim/bundle')
Plug 'maxmellon/vim-jsx-pretty'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/YankRing.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Townk/vim-autoclose'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-fugitive'
Plug 'eslint/eslint'
"Plug 'lifepillar/vim-solarized8'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ap/vim-css-color'
Plug 'rhysd/devdocs.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'leafgarland/typescript-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'liuchengxu/vista.vim'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

" Syntax highlighting

" Detect filetype
filetype plugin on
" Enable syntax highighting
syntax enable
" 256 colours, please
set t_Co=256
set termguicolors
" Dark solarized scheme
set background=dark
colorscheme nord
let g:airline_theme='nord'
let g:airline_solarized_bg='dark'

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:polyglot_disabled = ['jsx']
let g:jsx_ext_required = 0

" Set relevant filetypes
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.md set filetype=markdown

" set wildignore values (mainly for Command-T)
set wildignore=*.o,*.obj,node_modules/**
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,solr/**,log/**,*.psd,*.PSD,.git/**,.gitkeep,.gems/**
set wildignore+=*.ico,*.ICO,backup/**,*.sql,*.dump,*.tmp,*.min.js,Gemfile.lock
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
set wildignore+=vendor/**,coverage/**,tmp/**,rdoc/**,*.BACKUP.*,*.BASE.*,*.LOCAL.*,*.REMOTE.*,.sass-cache/**

" Tabs, indentation and lines

filetype plugin indent on
" 2 spaces please
set expandtab
set shiftwidth=2
"set tabstop=4
set softtabstop=2
" Round indent to nearest multiple of 4
"set shiftround

let g:indentLine_char = '┊'
nnoremap <leader>il :IndentLinesToggle

" Plug config
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Interactions

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

" Visual decorations

" Show status line
set laststatus=2
" Hide the current working mode, as Airline is installed
set noshowmode
" Show what commands you’re typing
set showcmd
" Allow modelines
set modeline
" Show current line and column position in file
set ruler
" Show file title in terminal tab
set title
" Set relative line numbers if we can...
if exists("+relativenumber")
    " Due to a problem with relative line numbers not persisting across new
    " tabs and splits, set no line numbers at all...
    set nonumber
    " ..then set relative ones.
    set relativenumber
" ...otherwise let’s just have regular ones.
else
    set number
endif
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
" remove scrollbars (MacVim)
set guioptions=-r
set guioptions=-R
set guioptions=-L
set guioptions=-l
" seems to remove scrollbars for NerdTree
set guioptions=
" set guifont=inconsolata-dz:h14
set guifont=Fira\ Code:h14

" save on loosing focus
au FocusLost * silent! update

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

au VimEnter * RainbowParenthesesToggle

" when Vim looses focus, switch automatically to Absolute Line Numbers
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" when entering insert mode switch to Absolute Line Numbers
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" Key mappings

" jj to throw you into normal mode from insert mode
inoremap jj <esc>
" jk to throw you into normal mode from insert mode
inoremap jk <esc>
" Disable arrow keys (hardcore)
map  <up>    <nop>
imap <up>    <nop>
map  <down>  <nop>
imap <down>  <nop>
map  <left>  <nop>
imap <left>  <nop>
map  <right> <nop>
imap <right> <nop>

" map ; to : for rapid commands etc
nnoremap ; :

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>

" shortcut to switch between relative line numbers
nnoremap <C-n> :call NumberToggle()<cr>

" reslect text that was just pasted
nnoremap <leader>v V`]

" open .vimrc in a split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" map F3 to :YRShow to show previously yanked text (Yankring)
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" set <Shift-t/T> to go forward/back between tabs
noremap <S-l> gt
noremap <S-h> gT

" set <Ctrl-l/h/j/k> to change pane
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

if !has('nvim')
  set ttymouse=xterm2
endif

" for Fzf
map <silent><C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

autocmd FileType css set omnifunc=csscomplete#CompleteCSS
noremap <C-x> <C-o><C-x><cr>

nmap K <Plug>(devdocs-under-cursor)

" coc
if expand('$INSTALL_COC_PLUGINS') == 'yes'
  :CocInstall coc-json
  :CocInstall coc-github
  :CocInstall coc-git
  :CocInstall coc-tsserver
  :CocInstall coc-html
  :CocInstall coc-css
  :CocInstall coc-svg
  :CocInstall coc-marketplace
  :CocInstall coc-tslint-plugin
  :CocInstall coc-tslint
  :CocInstall coc-eslint
  :CocInstall coc-emoji
  :CocInstall coc-prettier
endif

highlight clear SignColumn
highlight link SignColumn CursorColumn

autocmd BufWritePre * :%s/\s\+$//e " remove trailing spaces on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

nnoremap <Leader>m :Vista<CR>
let g:vista#renderer#enable_icon = 0
let g:vista_default_executive = 'coc'

nnoremap <silent><Leader>t :ter<CR>
nnoremap <silent><Leader>vt :vert ter<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <silent><Leader>t <C-\><C-n>:bd!<CR>

nnoremap <Leader>gb :CocList branches<CR>

" hide tmux status bar when vim starts, show when vim extts
autocmd VimEnter * silent !tmux set status off
autocmd VimLeave * silent !tmux set status on

map <C-u> :source $MYVIMRC<CR>
