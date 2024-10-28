return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

      lspconfig.jsonls.setup {
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

      lspconfig.vtsls.setup({
          on_attach = function(client, bufnr)
              local bufopts = { noremap=true, silent=true, buffer=bufnr }
              client.server_capabilities.document_formatting = false
              client.server_capabilities.document_range_formatting = false
              --[[ vim.keymap.set("n", "gs", ":TSLspOrganize<CR>", bufopts)
              vim.keymap.set("n", "gi", ":TSLspRenameFile<CR>", bufopts)
              vim.keymap.set("n", "go", ":TSLspImportAll<CR>", bufopts) ]]
          end,
          capabilites = capabilities
      })

      lspconfig.eslint.setup({
        --[[ on_attach = function(client, bufnr)
          client.server_capabilities.document_formatting = true
          client.server_capabilities.document_range_formatting = true
          vim.api.nvim_create_autocmd("BufWritePre", { callback = function() vim.lsp.buf.format() end })
        end, ]]
        capabilites = capabilities
      })

      lspconfig.sourcekit.setup{
        cmd = {"sourcekit-lsp", "--log-level", "error", "--stdio" },
        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp" },
        capabilites = capabilities
      }

      lspconfig.opts = {
        servers = {
          sourcekit = {
            cmd = {"sourcekit-lsp" }
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
        capabilites = capabilities
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
        capabilites = capabilities,
      }
    end
}

