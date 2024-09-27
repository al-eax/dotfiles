return {
    {
    'nvim-treesitter/nvim-treesitter',
    -- enabled=false,
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
                additional_vim_regex_highlighting = false,
                use_languagetree = false,
                disable = function(_, bufnr)
                    local buf_name = vim.api.nvim_buf_get_name(bufnr)
                    local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
                    print("fuck")
                    return file_size > 256 * 1024
                end,            
          }

        })
    end
    },
    {
        "nvim-treesitter/nvim-treesitter-context", -- show current class/function context
        enabled = false,
        config = function()
            require('treesitter-context').setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 3,-- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 2, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 1, -- Maximum number of lines to show for a single context (only show first line of multi line if-statements/function args)
                trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end
    }
}
