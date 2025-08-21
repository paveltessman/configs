-- ~/.config/nvim/lua/config/formatting.lua
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.black,
    -- Add other formatters/linters here
  },
})

-- -- Format on save
-- local format_group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = format_group,
--   pattern = "*.py",
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })


-- Set up filetype detection for Jinja files
-- vim.filetype.add({
--   extension = {
--     jinja = "jinja",
--     jinja2 = "jinja",
--     j2 = "jinja",
--   },
--   pattern = {
--     [".*%.jinja"] = "jinja",
--     [".*%.jinja2"] = "jinja",
--   },
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = {"jinja", "jinja2", "htmljinja"},
--   callback = function()
--     vim.opt_local.textwidth = 80
--     vim.opt_local.wrap = true
--     vim.opt_local.linebreak = false
--   end,
-- })
