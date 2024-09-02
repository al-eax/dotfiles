return {
  "lewis6991/gitsigns.nvim",
  config = function ()
    require('gitsigns').setup({
    })
    vim.api.nvim_create_user_command('Blame', ":Gitsigns toggle_current_line_blame", {}) -- toggle git blame

  end
}
