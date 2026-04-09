local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "lua", "python", "go",
                "vim", "vimdoc", "nasm",
                "javascript", "html", "markdown", "jinja" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = false },
        })
    end
}

return { M }
