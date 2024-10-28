vim.g.mapleader = ","
vim.g.maplocalleader = ","

require('tomoakley.set')
require('tomoakley.remap')


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- use ThePrimeagen's system of loading plugins
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy_init.lua
require("lazy").setup({
   spec = {
      { import = "tomoakley.plugins" },
    },
    change_detection = { notify = false }
})

require('Comment').setup()
require("xcodebuild").setup()

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
  callback = function(args)
    local bufopts = { noremap=true, silent=true, buffer=args.bufnr }
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
    vim.keymap.set('n', 'gdS', '<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
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
    if args.client.server_capabilities.document_formatting then
        autocmd("BufWritePre", {
          buffer = args.bufnr,
          callback = function()
            vim.lsp.buf.formatting_sync(nil, 1000)
          end
        })
        --vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
    end
  end
})

autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx,*.js,*.jsx",
  command = "EslintFixAll"
})
