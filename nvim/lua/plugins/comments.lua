return {
    -- uses gc to comment in/out selected code
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
    end
}
