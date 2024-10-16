return {

  {
    "lewis6990/gitsigns.nvim",
    -- enabled = false,
    config = function ()
      require('gitsigns').setup({
         signs = {
          add          = { text = '+' },
          change       = { text = '┃' },
          delete       = { text = '-' },
          topdelete    = { text = '-' },
          changedelete = { text = '|' },
          untracked    = { text = '┆' },
        },
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "right_align", --'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 0,
            ignore_whitespace = false,
            virt_text_priority = 99,
          },
        current_line_blame_formatter = '- <author>, <author_time:%R> - <summary>',
      })

      vim.api.nvim_create_user_command('Gblame', ":Gitsigns toggle_current_line_blame", {}) -- toggle git blame
      vim.api.nvim_create_user_command('Gdiff', function() -- inline diff 
        vim.cmd(":Gitsigns toggle_deleted")
        vim.cmd(":Gitsigns toggle_linehl")
      end, {}) 

      vim.api.nvim_create_user_command('Gdifff', function() -- diff for whole file
        vim.cmd(":Gitsigns diffthis")
      end, {}) 

      vim.api.nvim_create_user_command('Greset', function() -- undo/reset current honk (line)
        vim.cmd(":Gitsigns reset_hunk")
      end, {}) 

      vim.api.nvim_create_user_command('Gn', function() -- undo/reset current honk (line)
        vim.cmd(":Gitsigns next_hunk")
      end, {}) 
      vim.api.nvim_create_user_command('Gp', function() -- undo/reset current honk (line)
        vim.cmd(":Gitsigns prev_hunk")
      end, {}) 

      git = require('gitsigns')
      vim.keymap.set("n","<space>gj", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n","<space>gk", ":Gitsigns prev_hunk<CR>")
      vim.keymap.set("n","<space>gn", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n","<space>gp", ":Gitsigns prev_hunk<CR>")

      vim.keymap.set("n","<space>gd", ":Gdiff<CR>")
      vim.keymap.set("n","<space>gD", ":Gdifff<CR>")
      vim.keymap.set("n","<space>gr", ":Greset<CR>")

    end
  },
  {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true
}

}
