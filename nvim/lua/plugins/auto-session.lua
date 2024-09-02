vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    "rmagatti/auto-session",
    config = function()
        require('auto-session').setup({
            auto_session_enabled = true,
            auto_session_root_dir = vim.fn.expand "$HOME/.vimsessions/",
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_suppress_dirs = nil,
            auto_session_allowed_dirs = nil,
            auto_session_create_enabled = true,
            auto_session_enable_last_session = false,
            auto_session_use_git_branch = false,
            auto_restore_lazy_delay_enabled = true,
        })
    end
}