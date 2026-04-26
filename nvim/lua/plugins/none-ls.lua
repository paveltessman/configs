return {
    "nvimtools/none-ls.nvim",
    commit = "9a5d95cdf9f440683f248f6f0e97f8643804c91b",
    dependencies = {
        { "nvim-lua/plenary.nvim",         commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
        { "nvimtools/none-ls-extras.nvim", commit = "70659cc3d38151424298ab46b0f67f2251cef231" },
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                require("null-ls").builtins.formatting.black,
                require("null-ls").builtins.formatting.clang_format.with({
                    extra_args = { "--style={IndentWidth: 4, BasedOnStyle: LLVM}" },
                }),
                require("none-ls.diagnostics.flake8").with({
                    prefer_local = ".venv/bin",
                }),
            },
        })
    end
}
