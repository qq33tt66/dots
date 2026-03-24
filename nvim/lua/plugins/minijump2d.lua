require("mini.jump2d").setup()

local function make_fFtT_keymap(key, extra_opts)
	local opts = vim.tbl_deep_extend("force", { allowed_lines = { blank = false, fold = false } }, extra_opts)
	opts.hooks = opts.hooks or {}

	opts.hooks.before_start = function()
		local input = vim.fn.getcharstr()
    --stylua: ignore
    if input == nil then
      opts.spotter = function() return {} end
    else
      local pattern = vim.pesc(input)
      opts.spotter = MiniJump2d.gen_spotter.pattern(pattern)
    end
	end

	-- Using `<Cmd>...<CR>` enables dot-repeat in Operator-pending mode
	_G.jump2dfFtT_opts = _G.jump2dfFtT_opts or {}
	_G.jump2dfFtT_opts[key] = opts
	local command = string.format("<Cmd>lua MiniJump2d.start(_G.jump2dfFtT_opts.%s)<CR>", key)

	vim.api.nvim_set_keymap("n", key, command, {})
	vim.api.nvim_set_keymap("v", key, command, {})
	vim.api.nvim_set_keymap("o", key, command, {})
end

make_fFtT_keymap("f", { allowed_lines = { cursor_before = false } })
make_fFtT_keymap("F", { allowed_lines = { cursor_after = false } })
make_fFtT_keymap("t", {
	allowed_lines = { cursor_before = false },
	hooks = {
		after_jump = function()
			vim.api.nvim_input("<Left>")
		end,
	},
})
make_fFtT_keymap("T", {
	allowed_lines = { cursor_after = false },
	hooks = {
		after_jump = function()
			vim.api.nvim_input("<Right>")
		end,
	},
})
