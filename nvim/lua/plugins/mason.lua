return {
  "williamboman/mason.nvim",
  config = function ()
    local path_status_ok, path = pcall(require, "mason-core.path")
    if not path_status_ok then
            return
    end

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
  end
}
