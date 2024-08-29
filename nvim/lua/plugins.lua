-- plugins are installed here
-- run :PackerSync to install packages
-- packer is the plugin manager that downloads and loads plugins for nvim
-- see https://github.com/wbthomason/packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end



local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

  -- Have packer manage itself
  use 'wbthomason/packer.nvim'

  -- Install Telescope for file search 
  use {
    'nvim-telescope/telescope.nvim',tag = '0.1.8',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use "folke/todo-comments.nvim" -- TODO/FIXME
  -- install web-dev icons
  use 'nvim-tree/nvim-web-devicons'


  -- install theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Install nvim-tree file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', 
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }
  -- treesitter for source code parsing/AST building
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- nvim-cmp LSP & auto completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use { 'L3MON4D3/LuaSnip' }
  use 'saadparwaiz1/cmp_luasnip'
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'
  -- statusbar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  -- debugging
  use 'nvim-neotest/nvim-nio'
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'


  use 'folke/trouble.nvim' -- show diagnostics (warnings, errors, hints)

  -- bookmarks
  use 'tomasky/bookmarks.nvim'

  use "lukas-reineke/indent-blankline.nvim" -- display indent

  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!

  use { -- session handling
    'rmagatti/auto-session',
  }

  use { -- comments via gc
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- use 'nvim-treesitter/nvim-treesitter-context' -- display current function/class at top
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
}

  -- barbar : buffer in tabs
  use 'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
  use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
  use 'romgrk/barbar.nvim'
  
  use({
    "RRethy/vim-illuminate" -- highlight current word
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)

