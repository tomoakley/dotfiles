return {
  "axelvc/template-string.nvim",
  config = function()
    return {
      filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
      jsx_brackets = true, -- should add brackets to jsx attributes
    }
  end
}
