vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

function ToggleFocusNvimTree()
    local view = require("nvim-tree.view")
    if view.is_visible() then
        if vim.fn.bufname() == "NvimTree_1" then
            vim.cmd("NvimTreeClose")
        else
            vim.cmd("NvimTreeFocus")
        end
    else
        vim.cmd("NvimTreeToggle")
    end
end

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require("nvim-tree").setup({
            update_focused_file = { -- open path of the current file in tree view
                enable = true,
                update_root = false,
                ignore_list = {}
            },
            diagnostics = { -- enable LSP diagnostics
                enable = true
            },
            view = {
              side = "right"
            }

        })

        vim.keymap.set('n', '<leader>e', ToggleFocusNvimTree, { desc = "Trigger [E]xplorer" }) -- open file explorer by SPACE+e
        vim.keymap.set('n', '<leader>E', function() vim.cmd("NvimTreeClose") end, { desc = "Trigger [E]xplorer" }) -- open file explorer by SPACE+e
    end
}
