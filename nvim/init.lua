require("settings") -- load settings.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins",{
  change_detection = {
			notify = false, -- disable notification when nvim cfg was edited
		},
})


vim.opt.wrap = false
vim.opt.sidescrolloff = 36 -- Set a large value

vim.g.neominimap = {
  auto_enable = true,
}


-- keybinidngs
-- vim.keymap.set("n", "<leader>q", ":q!<CR>")
-- vim.keymap.set("n", "<leader>Q", ":q!<CR>")
vim.keymap.set("n", "<C-S>", ":w<CR>")


-- do not store in register
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "vv", "V")

-- redo
vim.keymap.set("n", "U", "<C-R>")

-- <leader>r search & replace only in visualy selected text
vim.keymap.set("v", "<leader>r", ":s/", { desc = "[R]eplace in selection" })
-- <leader>f search only in selected text
vim.keymap.set("v", "<leader>f", "<esc>/\\%V")

-- search in current buffer
vim.keymap.set("n", "<leader>f", ":%s/", { desc = "[F]ind in selection" })

-- searc & replace
vim.keymap.set("n", "<c-r>", ":%s/", { desc = "[R]eplace in whole buffer" })
vim.keymap.set("n", "<c-f>", "//g<left><left>", { desc = "[F]ind in current buffer" })

-- CTRL+A
vim.keymap.set("n", "<C-A>", "ggVG")
vim.keymap.set("v", "<C-A>", "<esc>ggVG")


-- serch seleced text:
vim.keymap.set("v", "<c-f>", "0y/<c-r>0")
vim.keymap.set("v", "<c-r>", "0y:%s/<c-r>0//g<left><left>")

-- clear highlight search text when <ECS>
vim.keymap.set("n", "<esc>", "<esc>:noh<CR>", { noremap = true })


-- window functions
vim.keymap.set("n", "<leader>w", "<C-W>")


-- macro recording
vim.keymap.set("n", "Q", "q1")
vim.keymap.set("n", "@", "@1", { noremap = true })



vim.keymap.set({ "n", "v" }, "J", "10j")
vim.keymap.set({ "n", "v" }, "K", "10k",{ noremap = false, silent = true })

