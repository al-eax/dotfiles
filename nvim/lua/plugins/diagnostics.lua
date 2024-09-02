
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
  { -- resize diagnostics of current line
    'sontungexpt/better-diagnostic-virtual-text',
    config = function(_)
      require('better-diagnostic-virtual-text').setup()
    end
  }
}
