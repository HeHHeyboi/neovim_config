-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "/config.vim"
cmd.source(vimrc)
require("config")

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})

vim.g.mapleader = " "
opt.smarttab = true
opt.encoding = "UTF-8"
opt.swapfile = false
opt.cursorline = true
opt.list = true
-- opt.listchars = { tab = "| " }
opt.listchars = { tab = "┆ ", leadmultispace = "┆   " }
-- opt.listchars = { tab = "┇ ", space = "" }

-- NOTE: Set Theme
-- cmd.colorscheme("onedark")
-- cmd.colorscheme("nordic")
cmd.colorscheme("kanagawa")
-- vim.g.ayucolor = "dark" -- "mirage" or "dark"
-- cmd.colorscheme("ayu")

cmd("set mouse=a")

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
cmd("set nofoldenable")
cmd("set foldlevel=999")
-- cmd("highlight MatchParen guibg=white guifg=black gui=NONE")

local gdproj = vim.fs.find('project.godot', { path = vim.fn.getcwd(), upward = true })
if #gdproj ~= 0 then
	-- local parent = vim.fs.dirname(gdproj[1])
	local addr = '/tmp/godot.pipe'
	if vim.uv.os_uname().sysname == "Windows_NT" then
		addr = '127.0.0.1:6004'
	end
	vim.fn.serverstart(addr)
end
