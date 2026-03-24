vim.pack.add({
	-- { src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/xeluxee/competitest.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	-- { src = "https://github.com/loctvl842/monokai-pro.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/Mofiqul/dracula.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
})

require("plugins.lualine")
require("plugins.minifiles")
require("plugins.miniai")
require("plugins.completion")
require("plugins.cgitsigns")
require("plugins.icons")
require("plugins.telescope")
require("plugins.mason")
require("plugins.conform")
require("plugins.mini")
require("plugins.minijump2d")
require("plugins.ui")
require("plugins.competitest")
require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.utils")
