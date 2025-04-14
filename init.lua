-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "/config.vim"
cmd.source(vimrc)
require("config")


opt.smarttab = true
opt.encoding = "UTF-8"
opt.swapfile = false
opt.cursorline = true
opt.list = true
-- opt.listchars = { tab = "| " }
opt.listchars = { tab = "┆ " }

-- opt.listchars = { tab = "┇ " }
-- NOTE: Select colorscheme

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
cmd("set nofoldenable")
cmd("set foldlevel=999")
-- cmd("highlight MatchParen guibg=white guifg=black gui=NONE")

if vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot') == 1 then
	local addr = './godot.pipe'
	if vim.fn.has('win32') then
		addr = '127.0.0.1:6004'
	end
	vim.fn.serverstart(addr)
end
