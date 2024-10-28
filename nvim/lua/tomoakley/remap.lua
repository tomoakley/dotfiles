vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set

-- jj and jk to throw you into normal mode from insert mode
map('i', 'jj', '<esc>')
map('i', 'jk', '<esc>')

-- Disable arrow keys (hardcore)
map({'n', 'i'}, '<up>', '<nop>')
map({'n', 'i'}, '<down>', '<nop>')
map({'n', 'i'}, '<left>', '<nop>')
map({'n', 'i'}, '<right>', '<nop>')

-- map ; to : for rapid commands etc
map('n', ';', ':', { noremap = true })
map('n', '<leader>v', '<C-w><C-v><C-l>:e $MYVIMRC<cr>', { noremap = true })

-- set <Shift-t/T> to go forward/back between tabs
map('n', '<S-l>', 'gt', { noremap = true })
map('n', '<S-h>', 'gT', { noremap = true })

-- set <Ctrl-l/h/j/k> to change pane
map({'n', 'i', 't'}, '<C-l>', '<Esc><C-w>l', { noremap = true })
map({'n', 'i', 't'}, '<C-h>', '<Esc><C-w>h', { noremap = true })
map({'n', 'i', 't'}, '<C-j>', '<Esc><C-w>j', { noremap = true })
map({'n', 'i', 't'}, '<C-k>', '<Esc><C-w>k', { noremap = true })

-- enter normal mode in terminal with Esc
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<Esc><Esc>', '<C-\\><C-n>:bw!<CR>')

-- use tab and shift tab to indent and de-indent code
map('n', '<Tab>', '>>', { noremap = true })
map('n', '<S-Tab>', '<<', { noremap = true })
map('v', '<Tab>', '>><Esc>gv', { noremap = true })
map('v', '<S-Tab>', '<<<Esc>gv', { noremap = true })

-- move lines up and down with alt j and k
map('n', '∆', ':m .+1<CR>==', { noremap = true })
map('i', '∆', ':m .+1<CR>==gi', { noremap = true })
map('v', '∆', ':m .+1<CR>==gv', { noremap = true })
map('n', '˚', ':m .-2<CR>==', { noremap = true })
map('i', '˚', ':m .-2<CR>==gi', { noremap = true })
map('v', '˚', ':m .-2<CR>==gv', { noremap = true })

-- Switch between last two files
map({'n', 'i'}, '<space><space>', '<C-^>', { noremap = true })

-- mapping for copy to clipboard from yank
map({'v', 'n'}, '<leader>p', "\"+p")
map({'v', 'n'}, '<leader>P', "\"+p")
map({'v', 'n'}, '<leader>y', "\"+y")
map({'v', 'n'}, '<leader>Y', "\"+y$")

-- open .vimrc in a split window
--map('n', '<leader>ev')
