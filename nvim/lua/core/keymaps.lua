vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")


-- Buffer navigation
vim.keymap.set("n", "<S-h>", ":bp<CR>")
vim.keymap.set("n", "<S-l>", ":bn<CR>")
vim.keymap.set("n", "<leader>q", ":bdelete<CR>")

-- Close all buffers except current
vim.keymap.set("n", "<leader>t", function()
    vim.cmd("%bd|e#|bd#")
end, { desc = "Close all buffers except current" })
vim.keymap.set("n", "<leader>;", "mmA;<Esc>`m")


local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'
vim.keymap.set("n", "<leader>fv", '<Cmd>Pick visit_paths cwd=""<CR>', { desc = "Visit paths (all)" })
vim.keymap.set("n", "<leader>f/", '<Cmd>Pick history scope="/"<CR>', { desc = '"/" history' })
vim.keymap.set("n", "<leader>f:", '<Cmd>Pick history scope=":"<CR>', { desc = '":" history' })
vim.keymap.set("n", "<leader>fa", '<Cmd>Pick git_hunks scope="staged"<CR>', { desc = "Added hunks (all)" })
vim.keymap.set("n", "<leader>fA", pick_added_hunks_buf, { desc = "Added hunks (buf)" })
vim.keymap.set("n", "<leader>fb", '<Cmd>Pick buffers<CR>', { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", '<Cmd>Pick git_commits<CR>', { desc = "Commits (all)" })
vim.keymap.set("n", "<leader>fC", '<Cmd>Pick git_commits path="%"<CR>', { desc = "Commits (buf)" })
vim.keymap.set("n", "<leader>fd", '<Cmd>Pick diagnostic scope="all"<CR>', { desc = "Diagnostic workspace" })
vim.keymap.set("n", "<leader>fD", '<Cmd>Pick diagnostic scope="current"<CR>', { desc = "Diagnostic buffer" })
vim.keymap.set("n", "<leader>ff", '<Cmd>Pick files<CR>', { desc = "Files" })
vim.keymap.set("n", "<leader>fg", '<Cmd>Pick grep_live<CR>', { desc = "Grep live" })
vim.keymap.set("n", "<leader>fG", '<Cmd>Pick grep pattern="<cword>"<CR>', { desc = "Grep current word" })
vim.keymap.set("n", "<leader>fh", '<Cmd>Pick help<CR>', { desc = "Help tags" })

vim.keymap.set("n", "<leader>fl", '<Cmd>Pick buf_lines scope="all"<CR>', { desc = "Lines (all)" })
vim.keymap.set("n", "<leader>fL", '<Cmd>Pick buf_lines scope="current"<CR>', { desc = "Lines (buf)" })
vim.keymap.set("n", "<leader>fm", '<Cmd>Pick git_hunks<CR>', { desc = "Modified hunks (all)" })
vim.keymap.set("n", "<leader>fM", '<Cmd>Pick git_hunks path="%"<CR>', { desc = "Modified hunks (buf)" })
vim.keymap.set("n", "<leader>fr", '<Cmd>Pick resume<CR>', { desc = "Resume" })
vim.keymap.set("n", "<leader>fR", '<Cmd>Pick lsp scope="references"<CR>', { desc = "References (LSP)" })
vim.keymap.set("n", "<leader>fs", pick_workspace_symbols_live, { desc = "Symbols workspace (live)" })
vim.keymap.set("n", "<leader>fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', { desc = "Symbols document" })

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]

vim.keymap.set("n", "<leader>gd", "<Cmd>Git diff<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>ga", "<Cmd>Git diff --cached<CR>", { desc = "Git staged diff" })
vim.keymap.set("n", "<leader>gc", "<Cmd>Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gl", "<Cmd>" .. git_log_cmd .. "<CR>", { desc = "Git log" })
vim.keymap.set("n", "<leader>gb", "<Cmd>Git blame<CR>", { desc = "Git blame" })

vim.keymap.set("n", "<leader>gs", function()
    MiniGit.show_at_cursor()
end, { desc = "Show commit at cursor" })

vim.keymap.set("n", "<leader>go", function()
    MiniDiff.toggle_overlay()
end, { desc = "Toggle inline diff" })

-- MINI.VISITS


local explore_quickfix = function()
    vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
    vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
end
local minifiles_toggle = function()
    if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    end
end

vim.keymap.set("n", "<leader>ee", minifiles_toggle)
vim.keymap.set("n", "<leader>ei", "<Cmd>edit $MYVIMRC<CR>", { desc = "init.lua" })
vim.keymap.set("n", "<leader>en", function() MiniNotify.show_history() end, { desc = "Notifications" })
vim.keymap.set("n", "<leader>eq", explore_quickfix, { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>eQ", explore_locations, { desc = "Location list" })




-- Vertical split and swap original buffer
vim.keymap.set("n", "<leader>sh", function()
    vim.cmd("vsplit")
    vim.cmd("wincmd h")
    vim.cmd("bprevious")
    vim.cmd("wincmd l")
end, { desc = "Split vertically right and clear original" })

-- Horizontal split and swap original buffer
vim.keymap.set("n", "<leader>sv", function()
    vim.cmd("split")
    vim.cmd("wincmd k")
    vim.cmd("bprevious")
    vim.cmd("wincmd j")
end, { desc = "Split horizontally below and clear original" })

-- Navigate splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })



-- COMPETITEST


vim.keymap.set("n", "<leader>ra", "<cmd>CompetiTest add_testcase<CR>",
    { noremap = true, silent = true, desc = "CompetiTest: Add testcase", })
vim.keymap.set("n", "<leader>rr", "<cmd>CompetiTest run<CR>",
    { noremap = true, silent = true, desc = "CompetiTest: Run tests", })

vim.keymap.set("n", "<leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
vim.keymap.set("n", "<leader>ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostic popup" })
vim.keymap.set("n", "<leader>li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Implementation" })
vim.keymap.set("n", "shift-k", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
vim.keymap.set("n", "<leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
vim.keymap.set("n", "<leader>lR", "<Cmd>lua vim.lsp.buf.references()<CR>", { desc = "References" })
vim.keymap.set("n", "<leader>ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Definition" })
vim.keymap.set("n", "<leader>lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition" })

vim.keymap.set("n", "<leader>ot", "<Cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim trailspace" })
vim.keymap.set("n", "<leader>oz", "<Cmd>lua MiniMisc.zoom()<CR>", { desc = "Zoom toggle" })

local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'

vim.keymap.set("n", "<leader>sd", "<Cmd>lua MiniSessions.select('delete')<CR>", { desc = "Delete session" })
vim.keymap.set("n", "<leader>sn", "<Cmd>lua " .. session_new .. "<CR>", { desc = "New session" })
vim.keymap.set("n", "<leader>sr", "<Cmd>lua MiniSessions.select('read')<CR>", { desc = "Read session" })
vim.keymap.set("n", "<leader>sw", "<Cmd>lua MiniSessions.write()<CR>", { desc = "Write current session" })

local new_scratch_buffer = function()
    vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end
vim.keymap.set("n", "<leader>ba", "<Cmd>b#<CR>", { desc = "Alternate buffer" })
vim.keymap.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", { desc = "Delete buffer!" })
vim.keymap.set("n", "<leader>bs", new_scratch_buffer, { desc = "Scratch buffer" })
vim.keymap.set("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout buffer" })
vim.keymap.set("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout buffer!" })
