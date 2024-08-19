require('plugins') -- load ./lua/plugins.lua



function ReloadConfig()
  -- Reload the init.lua file
  vim.cmd('source $MYVIMRC')
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end

-- auto wrap lines
vim.cmd(":set wrap linebreak nolist")

-- reload config
vim.api.nvim_create_user_command('ReloadCfg', ReloadConfig, {})

-- use system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('n', 'P', '"+P')

-- highlight current line
vim.opt.cursorline = true
-- highlight yanked text for 200ms using the "Visual" highlight group
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})
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

local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
vim.g.is_windows = is_windows
if is_windows then
    vim.g.os = "Windows"
else
    local uname_output = vim.fn.system('uname')
    vim.g.os = string.gsub(uname_output, '\n', '')
end


-- auto sync plugins via packer
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- ## Configure nvim-tree
require("nvim-tree").setup({

})

-- end nvim-tree

-- ## configure treesitter

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  compilers = { 'zig' }, -- TODO only on windows!

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

   

      -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- end treesitter


-- ## debugger
if vim.g.is_windows then
  local mason_python_path = [[C:\Users\ahh\AppData\Local\nvim-data\mason\packages\debugpy\venv\Scripts\python.exe]]
  require("dap-python").setup(mason_python_path)
else
  local mason_python_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"
  require("dap-python").setup(mason_python_path)
end


local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()

-- end debugger
-- ## configure lualine

local lualine = require('lualine')
lualine.setup({{
 "filename",path = 1
}})

-- end lualine


-- ## LSP configuration

vim.opt.completeopt = {}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)





require('mason').setup({
  ensure_installed = {"debugpy"}
})

require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {}
        },
        on_init = function(client)
          local uv = vim.uv or vim.loop
          local path = client.workspace_folders[1].name

          -- Don't do anything if there is a project local config
          if uv.fs_stat(path .. '/.luarc.json') 
            or uv.fs_stat(path .. '/.luarc.jsonc')
          then
            return
          end
          
          -- Apply neovim specific settings
          local lua_opts = lsp_zero.nvim_lua_ls()

          client.config.settings.Lua = vim.tbl_deep_extend(
            'force',
            client.config.settings.Lua,
            lua_opts.settings.Lua
          )
        end,
      })
    end,
  },
})

require('mason-tool-installer').setup {
  run_on_start = true,
  ensure_installed = {
    'debugpy',
    'lua_ls',
    'pyright',
  }
}

lsp_zero.setup() -- Make sure to finalize the LSP setup


-- ## nvim-cmp auto completion
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({

  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- scroll backward
    ['<C-f>'] = cmp.mapping.scroll_docs(4), -- scroll forward
    ['<C-Space>'] = cmp.mapping.complete {}, -- show completion suggestions
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- Tab through suggestions or when a snippet is active, tab to the next argument
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- Tab backwards through suggestions or when a snippet is active, tab to the next argument
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },  snippet = {
    expand = function(args)
      require 'luasnip'.lsp_expand(args.body)
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' }
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'luasnip',  keyword_length = 2 },
  }, {
    { name = 'buffer', keyword_length = 4 },
  })

})



-- ## configure LSP Keybindungs
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'gG', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<C-S-L>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})



-- Telescope
local builtin = require('telescope.builtin')
local ff = function()
  local _builtin = require('telescope.builtin')
  _builtin.find_files({no_ignore=true})
end
vim.keymap.set('n', '<leader>ff', ff, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- requred sudo apt-get install ripgrep on windows chkoco install ripgrep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default + actions.center,
            },
      n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
  },
}

-- nvim-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>") -- open file explorer by SPACE+e
vim.keymap.set("n", "<leader>q", ":q<CR>")


-- keybinidngs
vim.keymap.set("n", "<leader>q", ":q!<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
vim.keymap.set("n", "<C-S>", ":w<CR>")

vim.keymap.set({ "n", "v" }, "J", "10j")
vim.keymap.set({ "n", "v" }, "K", "10k")

-- do not store in register
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "vv", "V")

-- redo
vim.keymap.set("n", "U", "<C-R>")

-- <leader>r search & replace only in visualy selected text
vim.keymap.set("v", "<leader>r", ":s/")
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
vim.keymap.set("n", "<esc>", "<esc>:noh<CR>", { noremap = true })

-- switch bufferts
vim.keymap.set({ "n", "v" }, "<c-s-j>", ":bprev<cr>")
vim.keymap.set({ "n", "v" }, "<c-s-k>", ":bnext<cr>")


vim.keymap.set("n", "<leader>w", "<C-W>")


-- macro recording
vim.keymap.set("n", "Q", "q1")
vim.keymap.set("n", "@", "@1",{noremap = true})



-- Debugging Keymaps

vim.keymap.set("n", "<leader>db" , ":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>dc" , ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<F5>" , ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<F10>" , ":lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<F11>" , ":lua require'dap'.step_into()<cr>")


