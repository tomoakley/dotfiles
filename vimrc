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

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'chrome', 'vscode-node', 'reactnative' ]
packadd! vimspector

" Plugins, managed by vim-plug
call plug#begin('~/.config/nvim')
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'ap/vim-css-color'
"Plug 'leafgarland/typescript-vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kien/rainbow_parentheses.vim'
"Plug 'Townk/vim-autoclose'
Plug 'https://github.com/adelarsq/vim-matchit'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets', {'branch': 'main'}
Plug 'onsails/lspkind-nvim'
Plug 'tpope/vim-fugitive'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'eslint/eslint'
Plug 'janko/vim-test'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'liuchengxu/vista.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'unblevable/quick-scope'
Plug 'metakirby5/codi.vim'
Plug 'puremourning/vimspector'
Plug 'sunaku/vim-dasht'
Plug 'shuber/vim-promiscuous'
Plug 'sheerun/vim-polyglot'
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
colorscheme onenord

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
" set guifont=inconsolata-dz:h14
set guifont=Fira\ Code:h16

" save on loosing focus
au FocusLost * silent! update

" only activate quickscope highlights on t/T/f/F
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

set number

au VimEnter * RainbowParenthesesToggle

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

" shortcut to switch between relative line numbers
"nnoremap <silent><C-n> :NvimTreeToggle<CR>

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
tnoremap <C-l> <C-W>l
tnoremap <C-h> <C-W>h
tnoremap <C-j> <C-W>j
tnoremap <C-k> <C-W>k

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

" for Fzf
"map <silent><C-p> :Files<CR>
"nnoremap <Leader>b :Buffers<CR>
"nnoremap <Leader>h :History<CR>

" telescope
map <silent><C-p> <cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>
nnoremap <Leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>gg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <C-n> <cmd>lua require('telescope.builtin').file_browser()<cr>
vnoremap <leader>gs "zy <cmd>Telescope live_grep default_text=<C-r>z<cr>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

autocmd FileType css set omnifunc=csscomplete#CompleteCSS
noremap <C-x> <C-o><C-x><cr>

highlight clear SignColumn
highlight link SignColumn CursorColumn

autocmd BufWritePre * :%s/\s\+$//e " remove trailing spaces on save

" vim-test config and mappings
let test#strategy = "neovim"
let g:test#runner_commands = ['Jest']

function! JestStrategy(cmd)
  let options = {'configuration': 'jest', 'TestName': ''}
  let results = matchlist(a:cmd, '\v -t ''(.*)''')
  if !empty(results)
    let [all, testName, end; tail] = results
    let options.TestName = testName
  end
  call vimspector#LaunchWithSettings(options)
endfunction

let g:test#custom_strategies = {'jest': function('JestStrategy')}

nmap <silent> t<C-r> :
nmap <silent> t<C-n> :TestNearest -strategy=jest<CR>
nmap <silent> t<C-f> :TestFile -strategy=jest<CR>
nmap <silent> t<C-s> :TestSuite -strategy=jest<CR>
nmap <silent> t<C-l> :TestLast -strategy=jest<CR>
nmap <silent> t<C-g> :TestVisit -strategy=jest<CR>
nmap <silent> t<C-w> :Jest --watch<CR>

nnoremap <Leader>m :Vista<CR>
let g:vista#renderer#enable_icon = 0

" TERMINAL DRAWER {{{
    " depends on: CLEAN UI and Terminal Behavior
    nnoremap <silent><leader>/           :call ToggleTerminalDrawer()<CR>
    tnoremap <silent><leader>/ <C-\><C-n>:call ToggleTerminalDrawer()<CR>

    let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null }
    function! ToggleTerminalDrawer() abort
      if win_gotoid(g:terminal_drawer.win_id)
        hide
        set laststatus=2 showmode ruler
      else
        "if g:terminal_drawer.buffer_id && bufexists(str2nr(g:terminal_drawer.buffer_id)) == 1
        "  execute 'botright sbuffer' . g:terminal_drawer.buffer_id
        "  exec 'normal! i'
        "else
        "  botright call term_start($SHELL, {'exit_cb': 'JW_on_term_exit'})
        "  let g:terminal_drawer.buffer_id = bufnr("%")
        "endif
        botright new
        if g:terminal_drawer.buffer_id && bufexists(str2nr(g:terminal_drawer.buffer_id)) == 1
            exec "buffer" g:terminal_drawer.buffer_id
            call RemoveEmptyBuffers()
        else
            call termopen($SHELL, {"detach": 0})
            let g:terminal_drawer.buffer_id = bufnr("")
        endif

        exec "resize" float2nr(&lines * 0.25)
        exec 'normal! i'
        setlocal laststatus=0 noshowmode noruler nonumber norelativenumber
        setlocal nobuflisted
        let g:terminal_drawer.win_id = win_getid()

      endif
    endfunction

function! JW_on_term_exit(a, b)
    normal bw!
endfunction

function! RemoveEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        silent exe 'bw ' . join(buffers, ' ')
    endif
endfunction

function! QuickTerminal(cmd) abort
  let l:script = matchstr(a:cmd, '\v([a-z]*)(:)@=')
  let l:command = 'yarn ' . l:script
  echo l:command
  botright call termopen(l:command, {"detach": 0})
  au BufLeave <buffer> wincmd p
  nnoremap <buffer> <Enter> :q<CR>
  redraw
  echo "Press <Enter> to exit terminal (<Ctrl-C> first if command is still running)"
endfunction
command! -nargs=0 Scripts :call fzf#run(fzf#wrap({'source': 'cat ./package.json | jq ".scripts"', 'sink*': function('QuickTerminal')}))<CR>

lua << EOF
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local lspkind = require('lspkind')

require('lualine').setup({
  options = { theme = 'nord' }
})
require('nvim-tree').setup()
require('telescope').setup()

require("telescope").load_extension("git_worktree")

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end
local on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    buf_map(bufnr, 'n', 'gD', ':LspDec<CR>')
    buf_map(bufnr, "n", "gi", ':LspImplementation<CR>')
    buf_map(bufnr, "n", 'gr', ':LspRefs<CR>')
    buf_map(bufnr, "n", "gR", ":LspRename<CR>")
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    buf_map(bufnr, "n", "K", ":LspHover<CR>")
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
    buf_map(bufnr, "n", "<space>pr", ":LspFormatting<CR>")
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
    end
end
lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettierd",
        })
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})
require("null-ls").config({})
lspconfig["null-ls"].setup({ on_attach = on_attach })

cmp.setup {
     snippet = {
       expand = function(args)
         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
       end,
     },

      mapping = {
         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-e>"] = cmp.mapping.close(),
         ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
         },
         ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
         ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ select = false }),
          })
      },
      formatting = {
         format = lspkind.cmp_format {
            with_text = true,
            menu = {
               buffer   = "[buf]",
               nvim_lsp = "[LSP]",
               path     = "[path]",
            },
         },
      },

      sources = {
         { name = "nvim_lsp"},
         { name = "path" },
         { name = "buffer" , keyword_length = 5},
         { name = 'vsnip' }
      },
      experimental = {
         ghost_text = true
      }
}

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = false,
    },
    ensure_installed = {'javascript'}
  }
EOF

nnoremap <silent>K :Lspsaga hover_doc<CR>

"nnoremap <silent><C-r> :Rg<Cr>

nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>
let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp
let g:dasht_filetype_docsets['typescriptreact'] = ['typescript', 'javascript', 'react', 'nodejs']
let g:dasht_filetype_docsets['javascript'] = ['javascript', 'react', 'nodejs']

" hide tmux status bar when vim starts, show when vim extts
autocmd VimEnter * silent !tmux set status off
autocmd VimLeave * silent !tmux set status on

set clipboard=unnamed
map <C-r>c :source $MYVIMRC<CR>

let g:codi#rightsplit = 1
