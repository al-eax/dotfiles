return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', ":lua require('telescope.builtin').find_files({ no_ignore = true })<cr>", {desc = "[f]ind [f]iles"})
        vim.keymap.set('n', '<leader>fg', ":lua require('telescope.builtin').live_grep({ no_ignore = true })<cr>", {desc = "[f]ind text via live[g]ep"}) -- requred sudo apt-get install ripgrep on windows chkoco install ripgrep
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "[f]ind [b]uffer"})
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = "[f]ind [w]ord at cursor position"})

        local actions = require("telescope.actions")
        require('telescope').setup({
            defaults = {
                --file_ignore_patterns = { ".git/", "node_modules/", "*.log" , ".venv/", ".env/"},
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '-u'  -- do not consitder ignore files (.gitignore...)
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default + actions.center,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
        })
    end
}