require('plugins') -- load ./lua/plugins.lua


-- enable relative numbers
vim.wo.relativenumber = true

-- ## Configure nvim-tree
-- 
-- install Nerdfonts from https://www.nerdfonts.com/
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- empty setup using defaults

local nvim_tree_config = require("nvim-tree.config")
local tree_cb = nvim_tree_config.nvim_tree_callback

require("nvim-tree").setup( {
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},

	view = {
		width = 30,
		side = "left",
	}


})

-- ## Keymaps
vim.g.mapleader = ' ' -- set Space as leader key

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- nvim-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>") -- open file explorer by SPACE+e
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- own stuff
vim.keymap.set({"v","i"}, "<C-c>", "<Esc>") -- CTRL+c switch to normal mode
vim.keymap.set({"i","n"}, "<C-s>", "<Esc>:w<CR>") -- CTRL+s save current file
