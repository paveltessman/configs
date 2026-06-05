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

-- Create all daily notes for the current month
vim.keymap.set("n", "<leader>lD", function()
  local cwd = vim.fn.getcwd()
  if not cwd:match(".*life$") and not cwd:match(".*life/") then
    vim.notify("Not in the 'life' notes repo!", vim.log.levels.WARN)
    return
  end

  local year = tonumber(os.date("%Y"))
  local month = tonumber(os.date("%m"))
  local month_str = os.date("%Y-%m")
  local dir = string.format("%s/daily/%s", cwd, month_str)
  local template = cwd .. "/templates/daily.md"

  vim.fn.mkdir(dir, "p")

  local days_in_month = os.date("*t", os.time({ year = year, month = month + 1, day = 0 })).day
  local created = 0

  for day = 1, days_in_month do
    local path = string.format("%s/%04d-%02d-%02d.md", dir, year, month, day)
    if vim.fn.filereadable(path) == 0 then
      if vim.fn.filereadable(template) == 1 then
        vim.fn.system(string.format("cp %s %s", template, path))
      else
        vim.fn.writefile({}, path)
      end
      created = created + 1
    end
  end

  vim.notify(string.format("Created %d/%d daily notes for %s", created, days_in_month, month_str))
end, { desc = "Create all daily notes for current month" })

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
