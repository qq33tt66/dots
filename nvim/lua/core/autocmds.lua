local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local fn = vim.fn

autocmd("FileType", {
    callback = function() pcall(vim.treesitter.start) end,
})

-- removes trailing whitespace on save
autocmd("BufWritePre", {
    callback = function()
        local save_cursor = fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        fn.setpos(".", save_cursor)
    end,
})

-- highlights yanked text
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- restore cursor to last position when reopening a file
autocmd("BufReadPost", {
    desc = "Auto jump to last position",
    group = augroup("auto-last-position", { clear = true }),
    callback = function(args)
        local mark = api.nvim_buf_get_mark(args.buf, '"')
        local line_count = api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(api.nvim_win_set_cursor, fn.bufwinid(args.buf), mark)
        end
    end,
})

-- no auto continue comments on new line
autocmd("FileType", {
    group = augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- enforce 2-space indent and treesitter indentexpr for React/TS filetypes
-- (overrides $VIMRUNTIME/indent/typescript.vim which sets GetTypescriptIndent()
-- and has no JSX awareness, causing wrong indent levels on Enter inside JSX)
autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
})
