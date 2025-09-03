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

-- Netrw configuration
vim.g.netrw_banner = 0 -- Disable banner (clean look)
vim.g.netrw_liststyle = 0 -- Tree view
vim.g.netrw_browse_split = 0 -- Open in same window (fullscreen)
vim.g.netrw_altv = 1 -- Open splits to the right
vim.g.netrw_winsize = 100 -- Use full width
vim.g.netrw_preview = 1 -- Open previews vertically
vim.g.netrw_keepdir = 1 -- THIS IS THE KEY SETTING - Change directory as you browse
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro" -- Show line numbers, read-only

vim.opt.shortmess:append("sI")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("enew") -- Create new empty buffer
    end
  end,
})
