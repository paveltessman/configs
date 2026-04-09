return {
    "catppuccin/nvim",
    commit = "ce4a8e0d5267e67056f9f4dcf6cb1d0933c8ca00",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            color_overrides = {
                mocha = {
                    rosewater = "#ffc0b9",
                    flamingo = "#f5aba3",
                    pink = "#f592d6",
                    mauve = "#c0afff",
                    red = "#ea746c",
                    maroon = "#EAE4DD",
                    peach = "#fa9a6d",
                    yellow = "#ffe081",
                    green = "#d9ded7",
                    teal = "#47deb4",
                    sky = "#EAE4DD",
                    sapphire = "#00dfce",
                    blue = "#EAE4DD",
                    lavender = "#EAE4DD",
                    text = "#dddddd",
                    subtext1 = "#bbbbbb",
                    subtext0 = "#aaaaaa",
                    overlay2 = "#999999",
                    overlay1 = "#888888",
                    overlay0 = "#777777",
                    surface2 = "#666666",
                    surface1 = "#555555",
                    surface0 = "#444444",
                    base = "#151515",
                    mantle = "#222222",
                    crust = "#333333",
                }
            },
            no_italic = true,
        }
    end
}
