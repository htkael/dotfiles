-- Create ~/.config/nvim/lua/plugins/git.lua

return {
  -- Disable LazyVim's lazygit integration
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = { enabled = false },
    },
  },

  -- Add vim-fugitive (your original Git plugin)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>ga", "<cmd>Git add .<cr>", desc = "Git add all" },
      { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    },
  },

  -- Keep gitsigns for the gutter signs (you had this in your original config)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Your original gitsigns was just require('gitsigns').setup() with defaults
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
}
