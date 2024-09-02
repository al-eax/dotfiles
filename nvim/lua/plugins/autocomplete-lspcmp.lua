
-- LSP configuration and autocomplete


return {
    {
        "neovim/nvim-lspconfig", -- language servers for neovim
    },
    {
        -- plugin to enable autocomplete
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
                    ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- scroll backward
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- scroll forward
                    ['<C-Space>'] = cmp.mapping.complete {},    -- show completion suggestions
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
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
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
                    { name = 'path',     keyword_length = 2 },
                    { name = 'buffer',     keyword_length = 2 },
                })
            })
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp", -- plugin to display lsp suggestions in autocomplete
    },
    {
        "hrsh7th/cmp-buffer" -- plugin to display words from current buffer in autocomplete
    },
    {
        "hrsh7th/cmp-path" -- plugin to display paths in autocomplete
    },
    {
        "hrsh7th/cmp-cmdline"
    },
    {
        -- plugin to 
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.ui({
              float_border = 'rounded',
              sign_text = {
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»',
              },
            })
            local lsp_attach = function(client, bufnr) -- set keymaps if lsp attached to buffer
                local telescope = require('telescope.builtin')
                vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = bufnr, desc = "[H]over current word" })
                vim.keymap.set('n', 'gd', telescope.lsp_definitions, { buffer = bufnr, desc = "[G]oto [D]efinition" })
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = bufnr, desc = "[G]oto [D]eclaration" })
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { buffer = bufnr, desc = "[G]oto [I]mplementation" })
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { buffer = bufnr, desc = "" })
                vim.keymap.set('n', 'gr', telescope.lsp_references, { buffer = bufnr, desc = "[G]oto [R]eference(s)" })
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = bufnr, desc = "" })
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = bufnr, desc = "Rename current word" })
                vim.keymap.set('n', '<C-S-L>', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = bufnr, desc = "Rename current word" })
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                { buffer = bufnr, desc = "Format buffer" })
                vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                { buffer = bufnr, desc = "[F]or[m]at buffer" })
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = bufnr, desc = "Code action" })
                vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { buffer = bufnr, desc = "" })
                vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { buffer = bufnr, desc = "" })
                vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { buffer = bufnr, desc = "" })
                vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>', { buffer = bufnr, desc = "" })
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            lsp_zero.setup()
        end
    }
}