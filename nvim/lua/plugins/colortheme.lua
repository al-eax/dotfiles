vim.api.nvim_create_user_command('Theme', ":Telescope colorscheme", {})
vim.opt.termguicolors = true


return {
  {
    "catppuccin/nvim",
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    'folke/tokyonight.nvim'
  },
}
