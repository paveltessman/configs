-- The welcome screen
return {
    'goolord/alpha-nvim',
    commit = "3979b01cb05734331c7873049001d3f2bb8477f4",
    config = function()
        require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
};
