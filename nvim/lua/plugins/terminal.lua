-- Close the current Terminal (gitbash or others) ba CTRL+T
function CloseCurrentTerminalWithCtrlT(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-t>", "<cmd>close<CR>", {noremap = true, silent = true}) -- close current terminal by CTRL+T
end

return {
    {
        'akinsho/toggleterm.nvim', version = "*",
        config = function()
            require("toggleterm").setup(
                {
                    direction = "float",
                    float_opts = {
                        border = "curved"
                    }
                }
            )
            vim.keymap.set({"n","t","v"},"<c-t>", "<cmd>ToggleTerm<cr>", {desc = "Open/close [T]erminal"}) 

            local Terminal = require("toggleterm.terminal").Terminal

            if vim.g.is_windows then
                local Gitt = Terminal:new({
                    cmd = [["C:/Program Files/Git/bin/bash.exe" --login]],
                    hidden = true,
                    display_name = "Git Bash",
                    on_open = CloseCurrentTerminalWithCtrlT,
                    start_in_insert = true,
                }) 
                vim.api.nvim_create_user_command('Gitt',function() Gitt:toggle() end , {}) -- toggle git bash on windows
                vim.keymap.set({"n","t"}, "<c-g>",function() Gitt:toggle() end , {noremap = true, silent = true}) 
            end

        end
    }
}