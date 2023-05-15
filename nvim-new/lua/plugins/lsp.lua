local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local cmp = require("cmp")
local lspkind = require('lspkind')

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
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
        },
     },
  },

  sources = {
     { name = "nvim_lsp"},
     { name = "path" },
     { name = "buffer" , keyword_length = 5},
     { name = "luasnip" }
  },
  experimental = {
     ghost_text = true
  }
}
local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
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
lspconfig.eslint.setup({})
vim.cmd("autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx EslintFixAll")
lspconfig.sourcekit.setup{}

local circleciYamlPath = '/Users/toakley/Downloads/circleci-yamlls'
if not configs.circleciYamlls then
  configs.circleciYamlls = {
    default_config = {
      cmd = { circleciYamlPath };
      filetypes = { "yaml", "yml"};
    }
  }
end

lspconfig.circleciYamlls.setup({
  cmd = {
    circleciYamlPath
  },
})

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
  capabilites = capabilites
}

--require("null-ls").setup({})
--lspconfig["null-ls"].setup({ on_attach = on_attach })

vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })
