vim.api.nvim_set_hl(0, "MyReturn", { fg = "#e6565b", bold = true })
vim.fn.matchadd("MyReturn", "\\<return\\>")
