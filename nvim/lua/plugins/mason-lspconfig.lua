return {
  "williamboman/mason-lspconfig.nvim",
  commit = "0b9bb925c000ae649ff7e7149c8cd00031f4b539",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" },
      automatic_enable = false,
    })
  end

}
