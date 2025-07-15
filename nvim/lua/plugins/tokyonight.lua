return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night", -- night is the darkest variant
      transparent = true, -- Enable transparent background
      terminal_colors = true,
      styles = {
        sidebars = "transparent", -- Make sidebars transparent too
        floats = "transparent", -- Make floating windows transparent
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
