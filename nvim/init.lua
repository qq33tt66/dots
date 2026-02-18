vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/xeluxee/competitest.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" }
})

require("plugins.mason")
require("plugins.mini")
require("plugins.toggleterm")
require("plugins.competitest")
require("plugins.completion")
require("plugins.ui")
require("plugins.miniclue")
require("plugins.snippet")
require("plugins.treesitter")

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.utils")
