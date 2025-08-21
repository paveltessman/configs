require("vim-keymaps")
require("lazy-config")
require("formatting")


vim.cmd("colorscheme catppuccin")
vim.opt.colorcolumn = "89"

-- Disable Treesitter highlighting.
vim.cmd("TSDisable highlight")
