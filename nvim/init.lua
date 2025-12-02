require("vim-keymaps")
require("lazy-config")


vim.cmd("colorscheme catppuccin")
vim.opt.colorcolumn = "89"

-- Disable Treesitter highlighting.
vim.cmd("TSDisable highlight")

-- Configure LSP diagnostics display
vim.diagnostic.config({
  virtual_text = true,  -- Show error messages inline
  signs = true,         -- Show signs in the gutter
  underline = true,     -- Underline errors
  update_in_insert = false,  -- Don't update diagnostics while typing
  severity_sort = true,      -- Sort by severity
})
