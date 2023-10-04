return {
  mappings = {
    n = {
      ["<C-j>"] = {":bprev<CR>"},
      ["<C-k>"] = {":bnext<CR>"},

      ["J"] = {"10j"},
      ["K"] = {"10k"},
      ["<C-f>"] = {":/"},
      ["U"] = {":redo<CR>"},
      ["<C-r>"] = {":%s/"},

      ["Q"] = {"q1"},
      ["@"] = {"@1"},
    },
    v = {
      ["<C-f>"] = {"<esc>/\\%V"},
      ["<C-r>"] = {":s/", desc=""},
      ["J"] = {"10j"},
      ["K"] = {"10k"},
    }
  },
  colorscheme = "catppuccin",

  plugins = {
    {
      -- add "NORMAL", "INSERT", "VISUAL" tu statusline
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astronvim.utils.status")
        opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
          status.component.git_branch(),
          status.component.file_info { filetype = {}, filename = false, file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          -- remove the 2nd mode indicator on the right
        }

        -- return the final configuration table
        return opts
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
  },
}
