-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Your custom options from original config
vim.opt.spelllang = "en_gb"
vim.opt.title = true
vim.opt.titlestring = "nvim"

-- Cursor settings
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Scrolling
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- Disable swap files (your preference)
vim.opt.swapfile = false

-- LSP inlay hints
vim.lsp.inlay_hint.enable(true)

vim.filetype.add({
  pattern = {
    ["*/scripts/**"] = "sh",
  },
})

vim.g.netrw_banner = 0 -- Disable banner (clean look)
vim.g.netrw_liststyle = 3 -- Tree view
vim.g.netrw_browse_split = 0 -- Open in same window (fullscreen)
vim.g.netrw_altv = 1 -- Open splits to the right
vim.g.netrw_winsize = 100 -- Use full width
vim.g.netrw_preview = 1 -- Open previews vertically

-- Make netrw look more like your original setup
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro" -- Show line numbers, read-only

-- Auto-close netrw when opening a file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "h", "-", { buffer = buf, remap = true, desc = "Go up directory" })
    vim.keymap.set("n", "l", "<CR>", { buffer = buf, remap = true, desc = "Open file/directory" })

    vim.keymap.set("n", ".", "gh", { buffer = buf, remap = true, desc = "Toggle hidden files" })
    vim.keymap.set("n", "P", "<C-w>z", { buffer = buf, remap = true, desc = "Close preview" })
    vim.keymap.set("n", "q", ":bd<CR>", { buffer = buf, remap = true, desc = "Close netrw" })

    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no" -- Remove sign column for cleaner look
    vim.opt_local.foldcolumn = "0" -- Remove fold column
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "netrw" and vim.bo.buftype == "" then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "filetype") == "netrw" then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
  end,
})

vim.opt.shortmess:append("sI")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("enew") -- Create new empty buffer
    end
  end,
})
