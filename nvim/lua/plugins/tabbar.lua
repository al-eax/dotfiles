return {

  'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
  enabled = false,
  

  config = function()

    vim.opt.termguicolors = true

    require("bufferline").setup{
        options = {
          middle_mouse_command = "bdelete! %d", -- close buffer by middle mouse key click
          diagnostics = "nvim_lsp",
          show_buffer_icons = true, -- Symbole für Buffer anzeigen
          separator_style = "slant", -- Beispiel für verschiedene Stile
          numbers = "ordinal",
          offsets = {
            { -- offset for NvimTree
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          },
        }
    }
    local map = vim.api.nvim_set_keymap
    -- Move to previous/next
    map("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<c-h>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<c-l>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<a-k>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<a-j>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "" })

    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true, desc = "" })
    map("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true, desc = "" })
    vim.keymap.set("n", "<C-q>", function() 
      vim.cmd("bd") -- close current buffer
      vim.cmd("BufferLineCycleNext") -- switch to next buffer
    end)
    vim.keymap.set("n", "<a-q>", function() 
      vim.cmd("bd") -- close current buffer
      vim.cmd("BufferLineCycleNext") -- switch to next buffer
    end)
  end
}
