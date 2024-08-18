require('plugins') -- load ./lua/plugins.lua


function ReloadConfig()
  -- Reload the init.lua file
  vim.cmd('source $MYVIMRC')
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end
-- reload config 
vim.api.nvim_create_user_command('ReloadCfg', ReloadConfig, {})
-- use system clipboard
vim.api.nvim_set_option("clipboard","unnamedplus")
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('n', 'P', '"+P')



-- ## Keymaps
vim.g.mapleader = ' ' -- set Space as leader key

-- Load existing .vimrc file (loading keybindings)
-- vim.cmd([[
--   set runtimepath^=~/.vim runtimepath+=~/.vim/after
--   let &packpath = &runtimepath
--   source ~/.vimrc
-- ]])

-- enable relative numbers
vim.wo.relativenumber = true

local o = vim.o
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

vim.cmd.colorscheme "catppuccin"


-- auto sync plugins via packer
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- ## Configure nvim-tree
-- install Nerdfonts from https://www.nerdfonts.com/
-- 	* linux https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0 
-- disable netrw at the very start of your init.lua (strongly advised)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true
-- empty setup using defaults


require("nvim-tree").setup( {
	
})

-- end nvim-tree

-- ## configure treesitter

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" , "python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- end treesitter

-- ## configure lualine

local lualine = require('lualine')
lualine.setup()

-- end lualine


-- ## LSP configuration

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "pyright" },
  handlers = {
    function(server_name)
        require('lspconfig')[server_name].setup({})
      end,

       lua_ls = function()
      -- (Optional) configure lua language server
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

  }
})

lsp_zero.setup()  -- Make sure to finalize the LSP setup

-- ## nvim-cmp auto completion
local cmp = require('cmp')

cmp.setup({

  mappings = {
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  },
  snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'}
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' , keyword_length = 1},
    { name = 'luasnip' ,keyword_length = 2},
  }, {
    { name = 'buffer', keyword_length = 4},
  })

})



-- ## configure LSP Keybindungs
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'gG', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) 
  end
})



-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- requred sudo apt-get install ripgrep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- nvim-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>") -- open file explorer by SPACE+e
vim.keymap.set("n", "<leader>q", ":q<CR>")


-- keybinidngs
vim.keymap.set("n", "<leader>q", ":q!<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
vim.keymap.set("n", "<C-S>", ":w<CR>")

vim.keymap.set("n", "J", "10j")
vim.keymap.set("v", "J", "10j")
vim.keymap.set("n", "K", "10k")
vim.keymap.set("v", "K", "10k")

-- do not store in register
vim.keymap.set("n","d", '"_d')
vim.keymap.set("v","d", '"_d')
vim.keymap.set("n","dd", '"_dd')
vim.keymap.set("n", "vv", "V")

--
-- redo
vim.keymap.set("n", "U","<C-R>")

-- <leader>r search & replace only in visualy selected text
vim.keymap.set("v","<leader>r", ":s/")
-- <leader>f search only in selected text
vim.keymap.set("v", "<leader>f", "<esc>/\\%V")

-- search in current buffer
vim.keymap.set("n", "<leader>f", ":%s/")

-- searc & replace
vim.keymap.set("n", "<c-r>", ":%s/")
vim.keymap.set("n", "<c-f>", "//g<left><left>")

-- CTRL+A
vim.keymap.set("n", "<C-A>", "ggVG")
vim.keymap.set("v", "<C-A>", "<esc>ggVG")


-- serch seleced text:
vim.keymap.set("v", "<c-f>", "0y/<c-r>0")
vim.keymap.set("v", "<c-r>", "0y:%s/<c-r>0//g<left><left>")

-- clear search highlight text
vim.keymap.set("n", "<esc>", "<esc>:noh<CR>", {noremap = true})


