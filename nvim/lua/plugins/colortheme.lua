vim.api.nvim_create_user_command('Theme', ":Telescope colorscheme", {})
vim.api.nvim_create_user_command('Td', ":lua vim.cmd('colorscheme github_dark_colorblind')", {})
vim.api.nvim_create_user_command('Tl', ":lua vim.cmd('colorscheme github_light_colorblind')", {})
vim.opt.termguicolors = true


return {
  {
    "catppuccin/nvim",
    config = function()
      -- vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    'folke/tokyonight.nvim'
  },
  {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_dark_colorblind')
  end,
  }
}
