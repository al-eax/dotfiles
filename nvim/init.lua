require('plugins') -- load ./lua/plugins.lua


-- enable relative numbers
vim.wo.relativenumber = true

local o = vim.o
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

vim.cmd[[colorscheme tokyonight]]       -- set color theme
vim.cmd[[set clipboard+=unnamedplus]]   -- share/map system clipboard
vim.cmd[[set cursorline]]               -- highlight current line


-- ## Configure nvim-tree
-- 
-- install Nerdfonts from https://www.nerdfonts.com/
-- 	* linux https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0 
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- empty setup using defaults


require("nvim-tree").setup( {
	

})

-- ## Keymaps
vim.g.mapleader = ' ' -- set Space as leader key

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- requred sudo apt-get install ripgrep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- nvim-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>") -- open file explorer by SPACE+e
vim.keymap.set("n", "<leader>q", ":qa<CR>")

-- own stuff
vim.keymap.set({"v","i"}, "<C-c>", "<Esc>") -- CTRL+c switch to normal mode
vim.keymap.set({"i","n"}, "<C-s>", "<Esc>:w<CR>") -- CTRL+s save current file
