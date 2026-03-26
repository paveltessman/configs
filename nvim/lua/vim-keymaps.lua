vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

--disable swap file
vim.opt.swapfile = false

vim.o.scrolloff = 7

-- Theme settings
vim.o.background = "dark" -- or "light" for light mode


-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- vim.keymap.set('n', '<leader>fe', vim.cmd('Ex'), {desc = 'Open dir view'})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Daily note
vim.keymap.set("n", "<leader>ld", function()
  -- Check we're inside the 'life' repo
  local cwd = vim.fn.getcwd()
  if not cwd:match(".*life$") and not cwd:match(".*life/") then
    vim.notify("Not in the 'life' notes repo!", vim.log.levels.WARN)
    return
  end

  local date = os.date("%Y-%m-%d")
  local month = os.date("%Y-%m")
  local dir = string.format("%s/daily/%s", cwd, month)
  local path = string.format("%s/%s.md", dir, date)

  -- Create the month directory if needed
  vim.fn.mkdir(dir, "p")

  -- Copy template if the note doesn't exist yet
  if vim.fn.filereadable(path) == 0 then
    local template = cwd .. "/templates/daily.md"
    if vim.fn.filereadable(template) == 1 then
      vim.fn.system(string.format("cp %s %s", template, path))
    end
  end

  vim.cmd("edit " .. path)
end, { desc = "Open daily note" })

-- Daily food
vim.keymap.set("n", "<leader>lf", function()
  -- Check we're inside the 'life' repo
  local cwd = vim.fn.getcwd()
  if not cwd:match(".*life$") and not cwd:match(".*life/") then
    vim.notify("Not in the 'life' notes repo!", vim.log.levels.WARN)
    return
  end

  local date = os.date("%Y-%m-%d")
  local month = os.date("%Y-%m")
  local dir = string.format("%s/food/log/%s", cwd, month)
  local path = string.format("%s/%s.md", dir, date)

  -- Create the month directory if needed
  vim.fn.mkdir(dir, "p")

  -- Copy template if the note doesn't exist yet
  if vim.fn.filereadable(path) == 0 then
    local template = cwd .. "/templates/food.md"
    if vim.fn.filereadable(template) == 1 then
      vim.fn.system(string.format("cp %s %s", template, path))
    end
  end

  vim.cmd("edit " .. path)
end, { desc = "Open daily food log" })
