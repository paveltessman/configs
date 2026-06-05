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
