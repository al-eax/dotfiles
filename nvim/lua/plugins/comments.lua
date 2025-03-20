return {
  {
  -- uses gc to comment in/out selected code
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup()
  end
  },
  {
    "kkoomen/vim-doge", -- generate comments
    config = function() 
      -- Generate comment for current line
      vim.keymap.set('n', 'gc', '<Plug>(doge-generate)')

      -- Interactive mode comment todo-jumping
      vim.keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
      vim.keymap.set('i', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('i', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
      vim.keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
    end,
    build = function()
      vim.cmd(":call doge#install()")
    end
  }
}
