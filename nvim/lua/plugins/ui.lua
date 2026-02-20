require("trouble").setup()
require("tokyonight").setup({
    style = "moon",

    on_highlights = function(highlights, colors)
        highlights.Comment = {
            fg = "#FFD700",
            bg = "#2a2f4a",
            italic = true,
        }
    end,
})

vim.cmd.colorscheme("tokyonight-night")
