return {
  'stevearc/oil.nvim',
  commit = "cbcb3f997f6f261c577b943ec94e4ef55108dd95",
  opts = {},
  config = function()
    require("oil").setup({

      columns = {},
      keymaps = {
        ["_"] = "actions.toggle_hidden",
      },
      view_options = {
        show_hidden = false,
      },

    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
