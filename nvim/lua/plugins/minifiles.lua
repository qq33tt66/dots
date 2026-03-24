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
