return {
  "lewis6991/gitsigns.nvim",
  config = function ()
    require('gitsigns').setup({
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
    })
    vim.api.nvim_create_user_command('Blame', ":Gitsigns toggle_current_line_blame", {}) -- toggle git blame

  end
}
