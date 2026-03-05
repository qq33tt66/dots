require("mini.move").setup()

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup({
	custom_textobjects = {
		g = function()
			local from = { line = 1, col = 1 }
			local to = {
				line = vim.fn.line("$"),
				col = math.max(vim.fn.getline("$"):len(), 1),
			}
			return { from = from, to = to }
		end,
	},
})

require("mini.comment").setup()
require("mini.misc").setup()
require("mini.operators").setup()
require("mini.bufremove").setup()
require("mini.jump").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()

local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end
require("mini.pick").setup({
	window = { config = win_config },
	options = { use_cache = true },
})

require("mini.diff").setup({
	source = require("mini.diff").gen_source.save(),
})
local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		-- Load custom file with global snippets first
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
})
require("mini.extra").setup()
require("mini.files").setup({
	mappings = {
		close = "q",
		go_in = "l",
		go_out = "H",
		go_out_plus = "h",
		mark_goto = "'",
		mark_set = "m",
		reset = ".",
		synchronize = "s",
	},
	windows = {
		preview = true,
		width_preview = 50,
	},
})

require("core.minifilesgit").setup()

require("mini.visits").setup()
require("mini.sessions").setup()

require("mini.notify").setup()
require("mini.git").setup()
require("mini.starter").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.misc").setup()
require("mini.keymap").setup()
