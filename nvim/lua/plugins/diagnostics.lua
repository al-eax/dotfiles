
return {
  {
    "folke/trouble.nvim", -- show diagnostics
    config = function()
     require("trouble").setup()
      vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "[T]oggle [D]iagnostics" })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- show line indent
    config = function()
      require("ibl").setup()
    end
  },
  {
    "RRethy/vim-illuminate", -- highlight current word under cursor
    config = function()
      require('illuminate').configure()
    end
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    config = function()
      vim.opt.updatetime = 100
      vim.diagnostic.config { virtual_text = false }
      vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#f76464' })
      vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#f7bf64' })
      vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#64bcf7' })
      vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#64f79d' })
      require('tiny-inline-diagnostic').setup {
        blend = {
          factor = 0.001,
        },
      }
    end,
  }

}
