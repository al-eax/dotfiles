vim.cmd(
[[
  let g:minimap_width = 10
  let g:minimap_auto_start = 1
  let g:minimap_auto_start_win_enter = 1
]]
)
return {
  {
    enabled = false, -- doesnt work with coc, only works with lsp
    "folke/trouble.nvim", -- show diagnostics (only works with LSP and not with COC)
    config = function()
     require("trouble").setup({})
      vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "[T]oggle [D]iagnostics" })
      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")
      local telescope = require("telescope")
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
    'rachartier/tiny-inline-diagnostic.nvim', -- wrap diagnostics of the current line (only works with LSP, not with COC)
    event = 'VeryLazy',
    enabled = false,
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
  },
  { 
  "lewis6991/satellite.nvim", -- scollbar
    init = function()
     require('satellite').setup({
        width = 10
       })
    end
  } ,
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      require('dropbar').setup({
        general = {
            enable = true
          }
        })
    end
  }
}
