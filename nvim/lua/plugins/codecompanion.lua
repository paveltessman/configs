return {
  "olimorris/codecompanion.nvim",
  commit = "6384dc0d5b150394403e5ab3bc89bfad301634ea", -- Last commit supporting Neovim 0.10
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "claude",
        },
        inline = {
          adapter = "claude",
        },
        agent = {
          adapter = "claude",
        },
      },
      adapters = {
        claude = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
            schema = {
              model = {
                default = "claude-sonnet-4-20250514",
              },
            },
          })
        end,
      },
      display = {
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
          },
        },
        inline = {
          -- Enable inline completions
          layout = "vertical",
        },
      },
      opts = {
        -- Enable logging for debugging
        log_level = "ERROR",
      },
    })

    -- Keymaps for codecompanion
    vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
    vim.api.nvim_set_keymap("v", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
    vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Actions" })
    vim.api.nvim_set_keymap("v", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Actions" })
    vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true, desc = "Inline CodeCompanion" })
    vim.api.nvim_set_keymap("v", "<leader>ci", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true, desc = "Inline CodeCompanion" })

    -- Add to existing telescope commands if you use it
    vim.api.nvim_set_keymap("n", "<leader>cp", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Prompts" })
  end,
}
