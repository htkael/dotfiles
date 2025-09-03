-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
---- Auto-close netrw when opening a file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "h", "-", { buffer = buf, remap = true, desc = "Go up directory" })
    -- Map both l and <CR> to change directory and refresh netrw
    vim.keymap.set("n", ".", "gh", { buffer = buf, remap = true, desc = "Toggle hidden files" })
    vim.keymap.set("n", "P", "<C-w>z", { buffer = buf, remap = true, desc = "Close preview" })
    vim.keymap.set("n", "q", ":bd<CR>", { buffer = buf, remap = true, desc = "Close netrw" })
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
  end,
})

-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
