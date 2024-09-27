return {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local lualine = require('lualine')
        lualine.setup({
            sections = {
                lualine_c = { { 'filename', path = 1 } }
            },
        })
    end
}
