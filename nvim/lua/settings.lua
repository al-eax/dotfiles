local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
vim.g.is_windows = is_windows

-- auto wrap lines
vim.cmd(":set wrap linebreak nolist")
vim.cmd(":set ignorecase") -- ignore case sensitivity for search

vim.opt.wrap = false
vim.opt.sidescrolloff = 36 -- Set a large value

vim.opt.scrolloff = 10

-- use system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('n', 'P', '"+P')

-- highlight current line
vim.opt.cursorline = true

vim.g.mapleader = ' ' -- set Space as leader key

-- enable relative numbers
vim.wo.relativenumber = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2


-- highlight yanked text for 200ms using the "Visual" highlight group
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})


