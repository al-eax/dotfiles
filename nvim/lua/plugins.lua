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
 
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)

