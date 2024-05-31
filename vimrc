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

" Plugins, managed by vim-plug
call plug#begin('~/.config/nvim')
"Plug 'maxmellon/vim-jsx-pretty'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kien/rainbow_parentheses.vim'
Plug 'adelarsq/vim-matchit'
Plug 'skywind3000/asyncrun.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main'}
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
"Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
"Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-omni', {'branch': 'main'},
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*', 'do': 'make install_jsregexp'}
Plug 'onsails/lspkind-nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'axelvc/template-string.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'
"Plug 'eslint/eslint'
Plug 'tpope/vim-surround'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'unblevable/quick-scope'
Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'm4xshen/autoclose.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'
" can be lazy-loaded
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-jest'
"Plug 'voldikss/vim-floaterm'
Plug 'sunaku/vim-dasht'
Plug 'janko/vim-test'
Plug 'metakirby5/codi.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mxsdev/nvim-dap-vscode-js', { 'branch': 'start-debugging', 'do': 'npm install --legacy-peer-deps && npx gulp dapDebugServer' }
Plug 'nvim-orgmode/orgmode'
Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/gh.nvim'
Plug 'pwntester/octo.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'bennypowers/nvim-regexplainer/'
"Plug 'yardnsm/vim-import-cost', { 'do': 'npm install --production' }
Plug 'nvim-treesitter/playground'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'pwntester/octo.nvim'
Plug '~/code/nvim-circleci'
Plug 'xbase-lab/xbase', { 'do': 'make install' }
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
call plug#end()

augroup my_plugin_reload
    autocmd!
    autocmd BufWritePost ~/code/nvim-circleci/*.lua :call plug#load('nvim-circleci')
augroup END

" Enable Syntax highlighting
syntax on
syntax enable
set termguicolors

" Detect filetype
filetype plugin on

" Set relevant filetypes
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.md set filetype=markdown

" set wildignore values (mainly for Command-T)
"set wildignore=*.o,*.obj,node_modules/**
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,solr/**,log/**,*.psd,*.PSD,.git/**,.gitkeep,.gems/**
"set wildignore+=*.ico,*.ICO,backup/**,*.sql,*.dump,*.tmp,*.min.js,Gemfile.lock
"set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
"set wildignore+=vendor/**,coverage/**,tmp/**,rdoc/**,*.BACKUP.*,*.BASE.*,*.LOCAL.*,*.REMOTE.*,.sass-cache/**

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

" vim-test config and mappings
let test#strategy = "neovim"
let test#neovim#term_position = "vert botright 30"
let g:test#runner_commands = ['Jest']
" mappings replaced by neotest
"nmap <silent> t<C-n> :TestNearest<CR>
"nmap <silent> t<C-f> :TestFile <CR>
"nmap <silent> t<C-s> :TestSuite<CR>
"nmap <silent> t<C-l> :TestLast<CR>
"nmap <silent> t<C-g> :TestVisit<CR>
"nmap <silent> t<C-w> :Jest --watch<CR>

let test#javascript#jest#options = "--color=always --watchAll=false"
let g:asyncrun_open = 1
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" TERMINAL DRAWER {{{
    " depends on: CLEAN UI and Terminal Behavior
    " nnoremap <silent><leader>/           :call ToggleTerminalDrawer()<CR>
    " tnoremap <silent><leader>/ <C-\><C-n>:call ToggleTerminalDrawer()<CR>

    " let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null }
    " function! ToggleTerminalDrawer() abort
      " if win_gotoid(g:terminal_drawer.win_id)
        " hide
        " set laststatus=2 showmode ruler
      " else
        "if g:terminal_drawer.buffer_id && bufexists(str2nr(g:terminal_drawer.buffer_id)) == 1
        "  execute 'botright sbuffer' . g:terminal_drawer.buffer_id
        "  exec 'normal! i'
        "else
        "  botright call term_start($SHELL, {'exit_cb': 'JW_on_term_exit'})
        "  let g:terminal_drawer.buffer_id = bufnr("%")
        "endif
       " botright new
        " if g:terminal_drawer.buffer_id && bufexists(str2nr(g:terminal_drawer.buffer_id)) == 1
            " exec "buffer" g:terminal_drawer.buffer_id
            " call RemoveEmptyBuffers()
        " else
            " call termopen($SHELL, {"detach": 0})
            " let g:terminal_drawer.buffer_id = bufnr("")
        " endif

        " exec "resize" float2nr(&lines * 0.25)
        " exec 'normal! i'
        " setlocal laststatus=0 noshowmode noruler nonumber norelativenumber
        " setlocal nobuflisted
        " let g:terminal_drawer.win_id = win_getid()

      " endif
    " endfunction

" function! JW_on_term_exit(a, b)
    " normal bw!
" endfunction

" function! RemoveEmptyBuffers()
    " let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    " if !empty(buffers)
        " silent exe 'bw ' . join(buffers, ' ')
    " endif
" endfunction

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

set nofoldenable

lua << EOF
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local cmp = require("cmp")
local lspkind = require('lspkind')
local circleci = require('nvim-circleci')

require'nvim-web-devicons'.setup()

require("toggleterm").setup{
  open_mapping = '<leader>/',
  terminal_mappings = true,
  shade_terminals = true,
  shading_factor = 5,
  Normal = {
    guibg = 'NONE',
    ctermbg ="NONE"
  },
  auto_scroll = false,
  start_in_insert = false,
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
  direction = 'horizontal',
  persist_mode = false,
  highlights = {
    Normal = {
      link = "Normal",
    }
  }
}

-- local opts = {buffer = 0, silent = true}
-- vim.keymap.set('n', '<leader>/', ':ToggleTermToggleAll<CR>', opts)
-- vim.keymap.set('t', '<leader>/', ':ToggleTermToggleAll<CR>', opts)

require('onenord').setup({
  borders = false, -- Split window borders
  fade_nc = true -- fade non-active split
})
require('lualine').setup({
  options = { theme = 'onenord' },
  --[[ sections = {
    lualine_x = {
      {
        require("noice").api.status.message.get_hl,
        cond = require("noice").api.status.message.has,
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.search.get,
        cond = require("noice").api.status.search.has,
        color = { fg = "#ff9e64" },
      },
    },
  } --]]
})
vim.api.nvim_set_keymap("n", "<Leader>s", "", {
    callback = function()
        vim.opt.laststatus = 0
        local statusline = vim.o.statusline

        require("lualine").hide({
            place = { "statusline" },
            unhide = statusline == "" or statusline == "%#Normal#",
        })
    end,
})
require('telescope').setup({
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["<C-r>"] = require('telescope.actions').delete_buffer,
          ["<C-q>"] = function(bufnr)
            actions.smart_send_to_qflist(bufnr)
            require("telescope.builtin").quickfix()
          end,
        },
        i = {
          ["<C-r>"] = require('telescope.actions').delete_buffer,
        }
      }
    },
    lsp_references = {
      theme = "dropdown"
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  },
  defaults = {
    file_ignore_patterns = {"ios/Pods", ".yarn/", ".git"},
    dynamic_preview_title = true,
    path_display = {"truncate"},
    layout_config = {
      prompt_position = "top"
   }
  },
})
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('fzy_native')
require("telescope").load_extension("file_browser")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("circleci")
--vnoremap <leader>gs "zy <cmd>Telescope live_grep default_text=<C-r>z<cr>

local telescopeBuiltIn = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function()
  telescopeBuiltIn.find_files({ hidden = true })
end, {})
vim.keymap.set('n', '<leader>b', telescopeBuiltIn.buffers, {})
vim.keymap.set('n', '<leader>gg', telescopeBuiltIn.live_grep, {})
vim.keymap.set('n', '<leader>gs', function()
  telescopeBuiltIn.grep_string(require('telescope.themes').get_cursor())
end, {})
--vim.keymap.set('n', '<C-p>', telescopeBuiltIn.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  telescopeBuiltIn.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.api.nvim_set_keymap(
  "n",
  "<C-n>",
  ":Telescope file_browser<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gw",
  ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gwc",
  ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
  { noremap = true, silent = true }
)


local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspDocSyms lua require('telescope.builtin').lsp_document_symbols()")
    vim.cmd("command! LspRefs lua require('telescope.builtin').lsp_references()")
    vim.cmd("command! LspDiags lua require('telescope.builtin').diagnostics()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float(nil, { focus = false })")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    vim.keymap.set("n", "gd", ":LspDef<CR>", bufopts)
    vim.keymap.set('n', 'gD', ':LspDec<CR>', bufopts)
    vim.keymap.set("n", "gi", ':LspImplementation<CR>', bufopts)
    vim.keymap.set("n", 'gr', ':LspRefs<CR>', bufopts)
    vim.keymap.set("n", "gR", ":LspRename<CR>", bufopts)
    vim.keymap.set("n", "gy", ":LspTypeDef<CR>", bufopts)
    vim.keymap.set("n", "K", ":LspHover<CR>", bufopts)
    vim.keymap.set("n", "[a", ":LspDiagPrev<CR>", bufopts)
    vim.keymap.set("n", "]a", ":LspDiagNext<CR>", bufopts)
    vim.keymap.set("n", "ga", ":LspCodeAction<CR>", bufopts)
    vim.keymap.set("n", "<Leader>da", ":LspDiags<CR>", bufopts)
    vim.keymap.set("n", "<Leader>a", ":LspDiagLine<CR>", bufopts)
    vim.keymap.set("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", bufopts)
    vim.keymap.set("n", "<space>pr", ":LspFormatting<CR>", bufopts)
    vim.keymap.set("n", "gds", ":LspDocSyms<CR>", bufopts)
    if client.server_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
    end
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end


cmp.setup {
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { select = true }, { 'i', 'c' }),
    --['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<Tab>'] = cmp.mapping(function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
      end, {"i","s","c",}),

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  },
  formatting = {
     format = lspkind.cmp_format {
        with_text = true,
        menu = {
           buffer   = "[buf]",
           nvim_lsp = "[LSP]",
           path     = "[path]",
           omni = "[omni]"
        },
     },
  },

  sources = {
     { name = "nvim_lsp"},
     { name = "path" },
     { name = "buffer" , keyword_length = 5},
     { name = "luasnip" },
     { name = 'omni', option = { disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' } } }
  },
  experimental = {
     ghost_text = true
  }
}
local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Hide Javascript imports by default.
-- Refs: https://www.reddit.com/r/neovim/comments/seq0q1/plugin_request_autofolding_file_imports_using/
--[[ vim.api.nvim_create_autocmd("FileType",
  {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
      vim.opt_local.foldlevelstart = 19
      vim.opt_local.foldlevel = 19
      vim.opt_local.foldexpr =
      "v:lnum==1?'>1':getline(v:lnum)=~'import'?1:nvim_treesitter#foldexpr()"
    end,
    group = gib_autogroup
  }) ]]

require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = {"package.json"},
          url = "https://json.schemastore.org/package.json"
        }
      },
      validate = { enable = true },
      format = { enable = true }
    },
  }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline({
  }),
  sources = {
    { name = 'buffer' }
  },
  view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        --[[local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettierd",
        })
        ts_utils.setup_client(client)]]--
        vim.keymap.set("n", "gs", ":TSLspOrganize<CR>", bufopts)
        vim.keymap.set("n", "gi", ":TSLspRenameFile<CR>", bufopts)
        vim.keymap.set("n", "go", ":TSLspImportAll<CR>", bufopts)
        on_attach(client, bufnr)
    end,
    capabilites = capabilites
})
lspconfig.eslint.setup({
  --[[ on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true
    vim.api.nvim_create_autocmd("BufWritePre", { callback = function() vim.lsp.buf.format() end })
  end, ]]
  capabilites = capabilites
})
vim.cmd("autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx EslintFixAll")
lspconfig.sourcekit.setup{
  cmd = {"sourcekit-lsp", "--log-level", "error", "--stdio" },
  filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp" },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilites = capabilites
}

circleci.setup{
  lsp = {
    enable = true,
    config = {
      on_attach = on_attach,
      enable_yaml = true
    }
  }
}

local rescriptLspPath = '/Users/toakley/.config/nvim/vim-rescript/server/out/server.js'
if not configs.rescriptlsp then
  configs.rescriptlsp = {
    default_config = {
      cmd = {'node', rescriptLspPath, '--stdio'};
      filetypes = {"rescript", "res"};
      root_dir = lspconfig.util.root_pattern('bsconfig.json');
      settings = {};
    };
  }
end
lspconfig.rescriptlsp.setup{
  cmd = {
    'node',
    '/Users/toakley/.local/share/nvim/plugged/vim-rescript/server/out/server.js',
    '--stdio'
  },
  capabilites = capabilites
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilites = capabilites,
  on_attach = function(client, bufnr)
      on_attach(client, bufnr)
  end,
}

require("null-ls").setup({})
--lspconfig["null-ls"].setup({ on_attach = on_attach })

require('orgmode').setup_ts_grammar()
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'},
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
      enable = true
    },
    ensure_installed = {'javascript', 'typescript', 'tsx', 'org', 'lua', 'vim', 'help', 'swift'},
    playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_server_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
  }
require'treesitter-context'.setup {
  enable = true
}
require('template-string').setup({
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
  jsx_brackets = true, -- should add brackets to jsx attributes
})
require('regexplainer').setup({
  mappings = {
    toggle = '<leader>gr',
    show = 'gS',
    hide = 'gH',
    show_split = 'gP',
    show_popup = 'gU',
  },
})
require('Comment').setup()
require("nvim-autopairs").setup {
  disabled_filetypes = {"txt", "md", "org"}
}
--[[ require("autoclose").setup({
  options = {
    disabled_filetypes = { "text", "markdown", "org" },
  },
}) ]]
vim.keymap.set('n', '<esc>', '<cmd>RegexplainerHide<cr>')

-- dap
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

--[[ local dap_vscode_js_status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not dap_vscode_js_status_ok then
	return
end ]]

dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.api.nvim_set_hl(0, "blue",   { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "red",   { fg = "#BF616A" })
vim.api.nvim_set_hl(0, "green",  { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
vim.fn.sign_define('DapBreakpoint', {text='⚫', texthl='red', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', { text='⧁', texthl='green',  linehl='DapBreakpoint', numhl='DapBreakpoint' })

vim.keymap.set("n", 'd<leader>b', dap.toggle_breakpoint)
vim.keymap.set("n", 'd<leader>c', dap.continue)
vim.keymap.set("n", "d<leader>n", dap.step_over)
vim.keymap.set("n", "d<leader>i", dap.step_into)
vim.keymap.set("n", "d<leader>o", dap.step_out)
vim.keymap.set("n", "d<leader>C", dap.clear_breakpoints)
vim.keymap.set("n", "d<leader>k", dapui.eval)
vim.keymap.set("n", "d<leader>t", dapui.toggle)
--[[ ["<M-w>"] = dapui.elements.watches.add,
["<M-m>"] = dapui.float_element,
["<M-v>"] = function()
  dapui.float_element("scopes")
end,
["<M-r>"] = function()
  dapui.float_element("repl")
end, ]]

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>" },
    open = "o",
    remove = "d",
    edit = "e",
    toggle = "t",
    repl = "r",
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  layouts = {
    {
      elements = {
        'stacks',
        'breakpoints',
        'scopes',
      },
      size = 70,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
})

local path_status_ok, path = pcall(require, "mason-core.path")
if not path_status_ok then
	return
end

require('dap-vscode-js').setup({
  debugger_executable = '/Users/toakley/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
  adapters = { 'pwa-node' },
})

for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/.bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true
    },
    {
      name = "React native",
      type = "pwa-node",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      port = 35000,
    },
    {
      name = "Debug iOS Hermes - Experimental",
      -- type = "reactnativedirect",
      type = "pwa-node",
      request = "launch",
      platform = "ios",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      port = 35000,
    }
}
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

-- We need to wait for execution to stop at the first breakpoint before showing the UI to give the source maps time to generate.
-- If we don't, the UI will close because the source maps haven't generated in time.
dap.listeners.after.event_breakpoint["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
function getBranch()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD")
  local result = handle:read("*a"); handle:close()
  print(result)
  return result
end

require('orgmode').setup{
  org_agenda_files = {'~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/*'},
  org_default_notes_file = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org',
  org_capture_templates = {
    T = {
      description = 'Todo',
      template = '* TODO %a\n %u',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org'
    }
  }
}

--vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })

-- require('litee.lib').setup()
-- require('litee.gh').setup()
require"octo".setup()

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
  --dapui.open()
end, bufopts)

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require"octo".setup()
require'xbase'.setup({
  log_level = vim.log.levels.DEBUG,
  lspconfig.sourcekit.setup{
    cmd = {"xcrun", "sourcekit-lsp", "--log-level", "error" },
    filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp" },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    capabilites = capabilites,
    root_pattern = require ("lspconfig").util.root_pattern("Package.swift", "Sources", "xcodeproj", ".git"),
  }
})

lspconfig.opts = { servers = { sourcekit = { cmd = {"sourcekit-lsp" } } } }

require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline", -- Ensure this is set to "cmdline"
    opts = {},
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      -- other formats...
    },
 },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

EOF

" augroup import_cost_auto_run
"   autocmd!
"   autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
" augroup END
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_delay = 500

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
