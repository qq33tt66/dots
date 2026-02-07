-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  end
end

vim.keymap.set("n", "<leader>e", minifiles_toggle, {
  desc = "Toggle MiniFiles",
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit all buffers" })
-- CompetiTest keymaps
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

-- Typst compile
vim.keymap.set("n", "<leader>t", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("!typst compile " .. vim.fn.shellescape(file))
end, { noremap = true, silent = true })
