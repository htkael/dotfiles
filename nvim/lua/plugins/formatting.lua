return {
  {
    "stevearc/conform.nvim",
    opts = {
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
    },
    keys = {
      { "<leader>fo", function() require("conform").format() end, desc = "Format buffer" },
    },
  },
}
