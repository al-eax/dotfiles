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
    local use = use
    -- add you plugins here like:
    -- use 'neovim/nvim-lspconfig'

    -- Have packer manage itself
    use 'wbthomason/packer.nvim'

    -- Install Telescope for file search 
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

	-- install web-dev icons
	use 'nvim-tree/nvim-web-devicons'

    
    -- Install tokyonight theme
    use 'folke/tokyonight.nvim'

    -- Install nvim-tree file explorer
    use {
	    'nvim-tree/nvim-tree.lua',
	    requires = {
		    'nvim-tree/nvim-web-devicons', 
		    -- for windows: download & install https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/CascadiaCode.zip
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

	-- LSP plugins
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	

	-- statusbar
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)

