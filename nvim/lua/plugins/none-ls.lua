return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                require("null-ls").builtins.formatting.black,
                require("none-ls.diagnostics.flake8").with({
                    prefer_local = ".venv/bin",
                }),
            },
        })
    end
}
