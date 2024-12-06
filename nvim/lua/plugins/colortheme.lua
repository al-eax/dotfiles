vim.api.nvim_create_user_command('Theme', ":Telescope colorscheme", {})
vim.api.nvim_create_user_command('Td', ":lua vim.cmd('colorscheme github_dark_colorblind')", {})
vim.api.nvim_create_user_command('Tl', ":lua vim.cmd('colorscheme github_light_colorblind')", {})
vim.opt.termguicolors = true

vim.cmd([[
  " set guicursor=n-v-c:block-Cursor,i-ci-ve:ver25-CursorInsert,r-cr:hor20-CursorReplace,o:hor50
  set guicursor+=a:blinkon1
]]) -- make cursor visible & make cursor blink

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
      -- if an error occures, run :GithubThemeCompile
      vim.cmd('colorscheme github_dark_colorblind')
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#444444", underline = false })

    end,
  },
}
