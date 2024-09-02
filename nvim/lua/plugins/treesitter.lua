return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
   
    config = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
        local ts_config = require("nvim-treesitter.configs")
        ts_config.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript" },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            compilers = { 'zig' }, -- TODO only on windows!
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            indent = { enable = true },
            highlight = {
                enable = true,
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            }
        })
    end
}