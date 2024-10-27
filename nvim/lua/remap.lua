vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.cmd([[
  " jj and jk to throw you into normal mode from insert mode
  inoremap jj <esc>
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

  " enter insert mode in terminal with Esc
  tnoremap <Esc> <C-\><C-n>
  tnoremap <Esc><Esc> <C-\><C-n>:bw!<CR>

  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv

  " move lines up and down with alt j and k
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
]])
