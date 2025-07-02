-- -----------------------------------------------------------------------------------------------
-- General configuration
-- -----------------------------------------------------------------------------------------------
-- Basic settings
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"
vim.opt.title = true
vim.opt.titlestring = "nvim"

-- Leader (this is here so plugins etc pick it up)
vim.g.mapleader = " "  -- space as leader key

-- Re-enable netrw (built-in file explorer)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Display settings
vim.opt.termguicolors = true
vim.o.background = "dark"

-- Scrolling and UI settings
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- Persist undo (persists your undo history between sessions)
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- Swap file settings (to avoid swap file conflicts)
vim.opt.swapfile = false  -- Disable swap files
-- OR keep swap files but put them in a better location:
-- vim.opt.directory = vim.fn.stdpath("cache") .. "/swap//"

-- Tab stuff
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- open new split panes to right and below (as you probably expect)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- LSP
vim.lsp.inlay_hint.enable(true)

-- File type detection for shell files without extensions
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"shell_functions", "shell_aliases", "shell_exports", "zshrc", "bashrc", "profile", "install.sh", "*_functions", "*_aliases", "*_exports"},
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- -----------------------------------------------------------------------------------------------
-- Plugin list
-- -----------------------------------------------------------------------------------------------
local plugins = {
  { "nvim-lua/plenary.nvim" },                             -- used by several other plugins
  { "folke/tokyonight.nvim" },                             -- Tokyo Night theme
  { "nvim-lualine/lualine.nvim" },                         -- Status line

  -- Telescope command menu
  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  
  -- Harpoon for quick file navigation
  { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
  
  -- Git integration
  { "tpope/vim-fugitive" },                                -- Git commands
  { "lewis6991/gitsigns.nvim" },                           -- Git signs in gutter
  
  -- Auto-pairs for quotes, brackets, etc
  { "windwp/nvim-autopairs" },
  
  -- TreeSitter
  { "nvim-treesitter/nvim-treesitter", priority = 1000, build = ":TSUpdate" },
  {"nvim-treesitter/nvim-treesitter-context"},
  
  -- LSP
  { 'mason-org/mason.nvim' },                      -- installs LSP servers
  { 'neovim/nvim-lspconfig' },                     -- configures LSPs
  { 'mason-org/mason-lspconfig.nvim' },            -- links installed to configured
  { 'stevearc/conform.nvim' },                     -- Formatting where the LSP doesn't

  {
    'saghen/blink.cmp',                           -- Blink completion tool (LSP, snippets etc)
    version = '1.*',                              -- see keymap here:
    opts_extend = { "sources.default" },          -- https://cmp.saghen.dev/configuration/keymap.html#default
    opts = {
      keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" }
          }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    }
  },
}

-- -----------------------------------------------------------------------------------------------
-- Plugin installation
-- -----------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)

-- -----------------------------------------------------------------------------------------------
-- Plugin config
-- -----------------------------------------------------------------------------------------------
require("tokyonight").setup({
  style = "night", -- night is the darkest variant
  transparent = true, -- Enable transparent background
  terminal_colors = true,
  styles = {
    sidebars = "transparent", -- Make sidebars transparent too
    floats = "transparent", -- Make floating windows transparent
  },
})
vim.cmd.colorscheme("tokyonight")

require("lualine").setup()      -- the status line
require("telescope").setup()    -- command menu

-- Harpoon setup
local harpoon = require("harpoon")
harpoon:setup()

-- Gitsigns setup
require('gitsigns').setup()

-- Auto-pairs setup
require('nvim-autopairs').setup({
  check_ts = true,  -- Use treesitter for better pair detection
  ts_config = {
    lua = {'string'},-- Don't add pairs in lua string treesitter nodes
    javascript = {'string', 'template_string'},
    java = false,-- Don't check treesitter on java
  }
})

-- -----------------------------------------------------------------------------------------------
-- Treesitter (syntax highlighting and related stuff!)
-- -----------------------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "tsx", "json", "html", "css", "bash" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true, },
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- -----------------------------------------------------------------------------------------------
-- Treesitter Context
-- -----------------------------------------------------------------------------------------------
require("treesitter-context").setup({ 
  enable = true,
  multiwindow = false,
  max_lines = 0, 
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer', 
  mode = 'cursor',  
  separator = nil,
  zindex = 20,
  on_attach = nil,
})

-- -----------------------------------------------------------------------------------------------
-- LSP
-- -----------------------------------------------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup({ 
  ensure_installed = { "ts_ls", "bashls" } 
})

-- Configure LSP servers
local lspconfig = require('lspconfig')

-- LSP keybindings function
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>ai', vim.lsp.buf.add_workspace_folder, opts)
  
  -- Enable auto imports
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader>oi', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" }
        }
      })
    end, opts)
  end
end

-- TypeScript/JavaScript LSP setup
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  settings = {
    typescript = {
      suggest = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
    javascript = {
      suggest = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
  },
})

-- ESLint setup (disabled - not installed in project)
-- lspconfig.eslint.setup({
--   on_attach = on_attach,
-- })

-- Bash LSP setup  
lspconfig.bashls.setup({
  on_attach = on_attach,
})

require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
})

-- -----------------------------------------------------------------------------------------------
-- Keymap settings
-- -----------------------------------------------------------------------------------------------
-- Basic keys
vim.keymap.set("n", "q", "<C-r>")    -- "u" is undo, "q" is redo

-- Search navigation
-- n is always forward, N is always backward
-- ' is now forward and ; is backward
vim.keymap.set("n", "n", "v:searchforward ? 'n' : 'N'", { expr = true })
vim.keymap.set("n", "N", "v:searchforward ? 'N' : 'n'", { expr = true })
vim.keymap.set({ "n", "v" }, ";", "getcharsearch().forward ? ',' : ';'", { expr = true })
vim.keymap.set({ "n", "v" }, "'", "getcharsearch().forward ? ';' : ','", { expr = true })

-- toggle line numbers and wrap
vim.keymap.set("n", "<leader>n", ":set nonumber! relativenumber!<CR>")
vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>")

-- Move selected lines up/down (like Alt+Up/Down in VSCode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Moving between splits and resizing
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")  -- use Ctrl-j (and so on) to move between splits
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Formatting
vim.keymap.set("n", "<leader>fo", require('conform').format)

-- Telescope bindings
local tele_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")                      -- <space>pv to open netrw explorer
vim.keymap.set("n", "<leader>pf", tele_builtin.find_files, {})    -- <space>pf to find files
vim.keymap.set("n", "<leader>ps", tele_builtin.live_grep, {})     -- <space>ps to live grep
vim.keymap.set("n", "<leader>fb", tele_builtin.buffers, {})       -- <space>fb to see recent buffers
vim.keymap.set("n", "<leader>fh", tele_builtin.help_tags, {})     -- <space>fh to search help

-- Git bindings
vim.keymap.set("n", "<leader>gs", ":Git<CR>")                     -- <space>gs for git status (fugitive)
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")                -- <space>gp for git push
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>")                -- <space>gl for git pull

-- Harpoon bindings
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)                -- <space>a to add file to harpoon
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)  -- <space>e to open harpoon menu (changed from Ctrl+e)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)               -- <space>1 to go to file 1
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)               -- <space>2 to go to file 2
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)               -- <space>3 to go to file 3
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)               -- <space>4 to go to file 4
