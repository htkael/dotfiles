vim.keymap.set("n", "U", "<C-r>", { desc = "Redo (q instead of Ctrl-r)" })

-- Search navigation (n always forward, N always backward)
vim.keymap.set("n", "n", "v:searchforward ? 'n' : 'N'", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "v:searchforward ? 'N' : 'n'", { expr = true, desc = "Previous search result" })
vim.keymap.set({ "n", "v" }, ";", "getcharsearch().forward ? ',' : ';'", { expr = true, desc = "Repeat f/t backward" })
vim.keymap.set({ "n", "v" }, "'", "getcharsearch().forward ? ';' : ','", { expr = true, desc = "Repeat f/t forward" })

-- Toggle line numbers and wrap
vim.keymap.set("n", "<leader>n", ":set nonumber! relativenumber!<CR>", { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>", { desc = "Toggle line wrap" })

-- Move selected lines up/down (like Alt+Up/Down in VSCode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Moving between splits (LazyVim has these by default, but keeping your style)
vim.keymap.set("n", "<C-j>", "<C-W><C-J>", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-W><C-K>", { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", "<C-W><C-L>", { desc = "Move to split right" })
vim.keymap.set("n", "<C-h>", "<C-W><C-H>", { desc = "Move to split left" })

-- File explorer (netrw)
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Open oil file explorer" })

-- Buffer navigation shortcuts
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })
vim.keymap.set("n", "<leader>bo", ":only<CR>", { desc = "Close other buffers" })

-- Quick buffer switching (jump to buffer 1-9)
for i = 1, 9 do
  vim.keymap.set("n", "<leader>b" .. i, ":b" .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- Buffer list
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { desc = "List all buffers" })

-- Git bindings (with nowait to bypass which-key delays)
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status (fugitive)", nowait = true })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push", nowait = true })
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", { desc = "Git pull", nowait = true })
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit", nowait = true })
vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "Git add all", nowait = true })
vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { desc = "Git diff", nowait = true })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame", nowait = true })
