vim.api.nvim_create_user_command('Theme', ":Telescope colorscheme", {})

vim.cmd.colorscheme("catppuccin")

return {
  {
    "catppuccin/nvim",
  },
  {
    'folke/tokyonight.nvim'
  },
}
