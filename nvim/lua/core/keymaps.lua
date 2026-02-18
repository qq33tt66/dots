-- =====================================================
-- INSERT MODE
-- =====================================================

vim.keymap.set("i", "jk", "<Esc>:w<CR>", { noremap = true, silent = true })


-- =====================================================
-- CORE / BUFFER MANAGEMENT
-- =====================================================

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


-- =====================================================
-- FILE PICKING (mini.pick)
-- =====================================================

vim.keymap.set("n", "<leader><leader>", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")

-- Search word under cursor
vim.keymap.set("n", "<leader>sw", function()
    local word = vim.fn.expand("<cword>")
    require("mini.pick").builtin.grep({ pattern = word })
end, { desc = "Search word under cursor" })


-- =====================================================
-- MINI.VISITS
-- =====================================================

local MiniVisits = require("mini.visits")
vim.keymap.set("n", "<leader>r", MiniVisits.select_path)


-- =====================================================
-- MINI.FILES
-- =====================================================

local minifiles_toggle = function()
    if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    end
end

vim.keymap.set("n", "<leader>e", minifiles_toggle)


-- =====================================================
-- MINI.SESSIONS
-- =====================================================

vim.keymap.set("n", "<leader>ss", function()
    vim.ui.input({ prompt = "Session name: " }, function(name)
        if name then
            require("mini.sessions").write(name)
        end
    end)
end)

vim.keymap.set("n", "<leader>sr", function()
    require("mini.sessions").select()
end)


-- =====================================================
-- SPLITS
-- =====================================================

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


-- =====================================================
-- COMPETITEST
-- =====================================================

vim.keymap.set("n", "<leader>ra", "<cmd>CompetiTest add_testcase<CR>", {
    noremap = true,
    silent = true,
    desc = "CompetiTest: Add testcase",
})

vim.keymap.set("n", "<leader>rr", "<cmd>CompetiTest run<CR>", {
    noremap = true,
    silent = true,
    desc = "CompetiTest: Run tests",
})


-- =====================================================
-- LSP
-- =====================================================

-- Manual format
-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end,
})

-- =====================================================
-- Trouble
-- =====================================================

vim.keymap.set("n", "<leader>d", function()
    require("trouble").toggle("diagnostics")
end, { desc = "Workspace Diagnostics" })

vim.keymap.set("n", "<leader>fx", function()
    require("trouble").toggle("quickfix")
end, { desc = "Quickfix List" })
