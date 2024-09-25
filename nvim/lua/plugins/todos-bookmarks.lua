function GetBookmarkFile()
  -- get bookmrk file for current session (based on cwd path)
  local bookmarkdir = vim.fn.expand "$HOME/.vimbookmarks/"
  if vim.fn.isdirectory(bookmarkdir) == 0 then
    vim.fn.mkdir(bookmarkdir)
  end
  local cwd = vim.fn.getcwd()
  local cleaned_cwd = cwd:gsub("[/\\:]", "")
  local path = bookmarkdir .. cleaned_cwd .. ".json"
  -- print("load bookmarks from ", path)
  return path
end

return {
    {
        "folke/todo-comments.nvim", -- highlight INFO: TODO,FIXME and so on
        config = function()
            require("todo-comments").setup()
        end
    },
    {
        "tomasky/bookmarks.nvim",
        config = function()
            require("bookmarks").setup({
                -- sign_priority = 8,  --set bookmark sign priority to cover other sign
                save_file = GetBookmarkFile(), -- bookmarks save file path
                keywords = {
                    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
                    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
                    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
                },
                on_attach = function(bufnr)
                    local bm = require "bookmarks"
                    local map = vim.keymap.set
                    map("n", "mm", bm.bookmark_toggle)                             -- add or remove bookmark at current line
                    map("n", "mi", bm.bookmark_ann)                                -- add or edit mark annotation at current line
                    map("n", "mc", bm.bookmark_clean)                              -- clean all marks in local buffer
                    map("n", "mn", bm.bookmark_next)                               -- jump to next mark in local buffer
                    map("n", "mp", bm.bookmark_prev)                               -- jump to previous mark in local buffer
                    map("n", "ml", require('telescope').extensions.bookmarks.list) -- show marked file list in quickfix window
                    map("n", "md", bm.bookmark_clear_all)                          -- removes all bookmarks
                end
                })
            require('telescope').load_extension('bookmarks') -- allow keys "ml" to show bookmarked files in telescope
        end
    }
}
