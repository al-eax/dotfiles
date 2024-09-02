vim.api.nvim_create_user_command('Theme', ":Telescope colorscheme", {})

return {
    "catppuccin/nvim",
    config = function()
        vim.cmd.colorscheme "catppuccin"
    end
}
