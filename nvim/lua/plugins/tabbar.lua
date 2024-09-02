return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require('barbar').setup({
            maximum_length = 30, -- max file len
        })

        local map = vim.api.nvim_set_keymap
        -- Move to previous/next
        map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<c-h>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<c-l>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "" })

        -- Goto buffer in position...
        map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "" })
        map('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = "" })
        vim.keymap.set("n", "<C-q>", "<Cmd>BufferClose!<CR>")
        vim.keymap.set("n", "<A-q>", "<Cmd>BufferClose!<CR>")
    end
}