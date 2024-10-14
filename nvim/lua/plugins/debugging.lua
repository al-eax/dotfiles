
--- Check if file exists
function FileExists(filepath)
  local stat = vim.loop.fs_stat(filepath)
  return stat ~= nil
end

function ConfigureCsWorkspacesProject()
    local dap = require("dap")
    local startuipy = vim.fn.getcwd() .. '\\modules\\gui\\startui.py'
  
    if FileExists(startuipy) then
      table.insert(dap.configurations.python, {
          type = 'python',
          request = 'launch',
          name = 'start WSD',
          program = startuipy,  -- NOTE: Adapt path to manage.py as needed
      })

      table.insert(dap.configurations.python, {
          type = 'python',
          request = 'launch',
          name = 'start office WSD',
          program = startuipy,  -- NOTE: Adapt path to manage.py as needed
          args = {"--mode", "office"},
      })
    end
end

function ConfigureDjangoProject()
    -- only display Django if manage.py exists
    local dap = require("dap")
    local managepy = vim.fn.getcwd() .. '/manage.py'
    if FileExists(managepy) then
      table.insert(dap.configurations.python, {
          type = 'python',
          request = 'launch',
          name = 'Django',
          program = managepy,  -- NOTE: Adapt path to manage.py as needed
          args = {'runserver', '--noreload'},
      })
    end
end

return{
    { "nvim-neotest/nvim-nio"},
    {
        'mfussenegger/nvim-dap-python',
        config = function()
            -- pyright & debugpy was downloaded by mason, we have to select masoons venv
            if vim.g.is_windows then
                local mason_python_path = [[C:\Users\ahh\AppData\Local\nvim-data\mason\packages\debugpy\venv\Scripts\python.exe]]
                require("dap-python").setup(mason_python_path)
            else
                local mason_python_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"
                require("dap-python").setup(mason_python_path)
            end
        end
    },
    { 
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")

            if dap.configurations.python == nil then
                dap.configurations.python = {}
            end
            -- add django configuration
            ConfigureDjangoProject()
            ConfigureCsWorkspacesProject()

            vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = '', linehl = '', numhl = '' })

            vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>", { desc = "[D]ebug: toggle [B]reakpoint" })
            --vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<cr>", { desc = "[D]ebug: [C]ontinue/Start" })
            vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<cr>")

            vim.keymap.set("n", "<F6>", ":lua require'dap'.step_over()<cr>")
            vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<cr>")
            vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<cr>")
            vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<cr>")
        end
    },
    
    { 
       'rcarriga/nvim-dap-ui',
        config = function()
            local dapui = require("dapui")
            dapui.setup()
            
            local dap = require("dap")
            
          
            
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            vim.api.nvim_create_user_command('Dap', dapui.toggle, {}) -- toggle dapui
            vim.keymap.set("n", "<leader>de", ":lua require'dapui'.eval()<cr>", { desc = "[D]ebug: [Eval] current cursor position" })
            vim.keymap.set("n", "<leader>du",dapui.toggle)
        end
    },
    { 
       'theHamsta/nvim-dap-virtual-text',
        config = function()
            require("nvim-dap-virtual-text").setup({
                commented = true,
                virt_text_pos = "eol",
                only_first_definition = false,
                all_references = false
            })
        end
    },
}
