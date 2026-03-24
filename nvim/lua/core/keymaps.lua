local map = vim.keymap.set

-- Basic mappings
map("i", "jk", "<Esc>", { noremap = true, silent = true })
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")

-- File / buffer
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "F2", "<cmd>typst compile %<cr>", { desc = "Compile typst" })
map("n", "<S-h>", ":bp<CR>")
map("n", "<S-l>", ":bn<CR>")
map("n", "<leader>q", ":bdelete<CR>")
map("n", "<leader>u", "<cmd>wqall<cr>", { desc = "Save all and quit" })
map("n", "<leader>t", function()
	vim.cmd("%bd|e#|bd#")
end, { desc = "Close all buffers except current" })

-- Open in browser
map("n", "<leader>gn", function()
	vim.fn.jobstart({ "google-chrome-stable", vim.fn.expand("%:p") }, { detach = true })
end, { desc = "Open current HTML file in browser" })

-- Mini files
map("n", "<leader>e", function()
	if not MiniFiles.close() then
		MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	end
end, { desc = "File explorer" })

-- Splits
map("n", "<leader>sh", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd h")
	vim.cmd("bprevious")
	vim.cmd("wincmd l")
end, { desc = "Split vertically right" })
map("n", "<leader>sv", function()
	vim.cmd("split")
	vim.cmd("wincmd k")
	vim.cmd("bprevious")
	vim.cmd("wincmd j")
end, { desc = "Split horizontally below" })

-- Navigate splits
for key, dir in pairs({ h = "h", j = "j", k = "k", l = "l" }) do
	map("n", "<C-" .. key .. ">", "<C-w>" .. dir, { desc = "Move to " .. dir .. " split" })
end

-- CompetiTest
map("n", "<leader>ra", "<cmd>CompetiTest add_testcase<CR>", { noremap = true, silent = true, desc = "Add testcase" })
map("n", "<leader>rr", "<cmd>CompetiTest run<CR>", { noremap = true, silent = true, desc = "Run tests" })

-- Telescope: LSP
for _, v in ipairs({
	{ "<leader>ls", "lsp_definitions", "Definitions" },
	{ "<leader>lt", "lsp_type_definitions", "Type definitions" },
	{ "<leader>li", "lsp_implementations", "Implementations" },
	{ "<leader>lR", "lsp_references", "References" },
	{ "<leader>lS", "lsp_document_symbols", "Document symbols" },
	{ "<leader>lW", "lsp_workspace_symbols", "Workspace symbols" },
}) do
	map("n", v[1], "<cmd>Telescope " .. v[2] .. "<cr>", { desc = v[3] })
end
-- Telescope: files & search
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fw", function()
	require("telescope.builtin").grep_string()
end, { desc = "Search word under cursor" })
map("n", "<leader>fn", function()
	require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find files in config dir" })

for _, v in ipairs({
	{ "<leader>fg", "live_grep", "Live grep" },
	{ "<leader>fb", "buffers", "Buffers" },
	{ "<leader>fr", "oldfiles", "Recent files" },
	{ "<leader>fc", "commands", "Commands" },
	{ "<leader>fh", "help_tags", "Help tags" },
	{ "<leader>fk", "keymaps", "Keymaps" },
	{ "<leader>fo", "vim_options", "Vim options" },
	{ "<leader>ff", "current_buffer_fuzzy_find", "Search in buffer" },
	{ "<leader>fs", "treesitter", "Treesitter symbols" },
	{ "<leader>xd", "diagnostics", "Diagnostics" },
	{ "<leader>gC", "git_commits", "Git commits" },
	{ "<leader>gL", "git_bcommits", "Buffer commits" },
	{ "<leader>gB", "git_branches", "Git branches" },
	{ "<leader>gS", "git_status", "Git status" },
	{ "<leader>gZ", "git_stash", "Git stash" },
}) do
	map("n", v[1], "<cmd>Telescope " .. v[2] .. "<cr>", { desc = v[3] })
end

-- Gitsigns
local gs = require("gitsigns")
map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Inline preview" })
