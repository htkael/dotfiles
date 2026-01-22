return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = false, -- Disable gopls
        jdtls = {},
        ts_ls = {
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
        },
        bashls = {},
      },
    },
    init = function()
      -- Your custom LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }
          -- Add organize imports keymap
          vim.keymap.set("n", "<leader>oi", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.organizeImports" },
              },
            })
          end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
          -- Add workspace folder keymap
          vim.keymap.set(
            "n",
            "<leader>ai",
            vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
          )
        end,
      })
    end,
  },
}
