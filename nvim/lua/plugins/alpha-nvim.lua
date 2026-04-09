-- The welcome screen
return {
    'goolord/alpha-nvim',
    commit = "3979b01cb05734331c7873049001d3f2bb8477f4",
    config = function()
        local startify = require("alpha.themes.startify")
        startify.file_icons.enabled = false
        require("alpha").setup(
            startify.config
        )
    end
};
