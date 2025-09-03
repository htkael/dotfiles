return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Override default LazyVim keymaps with your preferred ones
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Recent buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>pa", "<cmd>Telescope resume<cr>", desc = "Resume search" },
    },
  },
}
