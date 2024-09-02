return {
    {
        -- plugin to install language servers, linters, formatters, debuggers...
        'williamboman/mason.nvim',
        config = function() 
            require('mason').setup({})
        end
    },
    {
      -- plugin to setup installed lsp servers
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        "VonHeikemen/lsp-zero.nvim"
      },
        config = function()
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name) -- setup each lsp server
                        require('lspconfig')[server_name].setup({})
                    end,
                    lua_ls = function() -- setup lua lsp
                        require('lspconfig').lua_ls.setup({
                              settings = {
                                Lua = {
                                  diagnostics = {
                                    globals = {'vim'}
                                  }
                                }
                            },
                            on_init = function(client)
                              local uv = vim.uv or vim.loop
                                local path = client.workspace_folders[1].name

                              -- Don't do anything if there is a project local config
                              if uv.fs_stat(path .. '/.luarc.json')

                              then
                                  return
                              end

                              -- Apply neovim specific settings
                              -- local lua_opts = lsp_zero.nvim_lua_ls()
                              --
                              -- client.config.settings.Lua = vim.tbl_deep_extend(
                              --     'force',
                              --     client.config.settings.Lua,
                              --     lua_opts.settings.Lua
                              -- )
                            end,
                        })
                    end,
                },
            })
        end
    },
    {
        -- plugin to auto install language servers, linters, formatters, debuggers
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup({
                run_on_start = true,
                ensure_installed = {
                    'debugpy',
                    'lua_ls',
                    'pyright',
                    'stylua',
                    'typescript-language-server',
                    'eslint-lsp', -- ts/js formatting
                    'js-debug-adapter',
                }
            })
        end
    },

}
