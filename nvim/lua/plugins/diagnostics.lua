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
--     {
--     "wellle/context.vim", -- show current context (class/func) at top of the window
--     config = function()
--       vim.cmd(
--         [[
          -- let g:context_enabled = 1
          -- let g:context_throttle = 100  " Kontrolle der Aktualisierungsfrequenz
          -- let g:context_add_mappings = 0
          -- let g:context_max_lines = 3   " Maximiere die angezeigten Zeilen für context.vim
          -- let g:context_type = 'virtual'  " Kann 'floating' sein, falls du Popups wünschst
          -- autocmd VimEnter * call context#move('#', 'below')
--         ]]
--       )
--     end
--
--   },
  {
    'Bekaboo/dropbar.nvim', -- show current file path in header
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      local utils = require('dropbar.sources')
      require('dropbar').setup({
        general = {enable = true },
      })
    end
  },

  -- {
  --   "psf/black", -- python code formating: install black systemwide python -m pip install black
  --   config = function()
  --     vim.cmd(
  --       [
  --         let g:black_use_virtualenv = 0
  --         augroup black_on_save
  --           autocmd!
  --           autocmd BufWritePre *.py Black
  --         augroup end
  --       ]]
  --     )
  --   end
  -- }
  {
    "hedyhli/outline.nvim", -- display classes & functions of the current file
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
      { desc = "Toggle Outline" })

      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
        symbols = {
          filter = {
            default = { 'String', exclude=true},
            -- default = { 'Function', 'Class' },
          }
        },
        preview_window = {
          auto_preview = true,
        },
      }
    end,  
  },
}
