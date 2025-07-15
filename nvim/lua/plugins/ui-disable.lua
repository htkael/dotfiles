return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        custom_filter = function(buf_number)
          local buf_type = vim.api.nvim_buf_get_option(buf_number, "buftype")
          local file_type = vim.api.nvim_buf_get_option(buf_number, "filetype")
          if file_type == "netrw" or buf_type == "help" or buf_type == "quickfix" then
            return false
          end
          return true
        end,
      },
    },
  },
}
