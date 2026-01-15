-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "/config.vim"
local keymap = vim.fn.stdpath("config") .. "/vim/keymap.vim"
vim.cmd("so " .. vimrc)
vim.cmd("so " .. keymap)
require("config")
if vim.uv.os_uname().sysname == "Windows_NT" then
	cmd("let &shell = 'nu'")
	cmd("let &shellcmdflag = '--error-style plain -c'")
	cmd("let &shellquote = \"\"")
	cmd("let &shellxquote = \"\"")
	cmd("set shellslash")
end
-- vim.o.winborder = "rounded"

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})

-- NOTE: vim options
vim.g.mapleader = " "
opt.smarttab = true
opt.encoding = "UTF-8"
opt.swapfile = false
opt.cursorline = false
opt.wrap = false
opt.sidescroll = 20
opt.sidescrolloff = 10
opt.list = true
-- opt.listchars = { tab = "| " }
opt.listchars = { tab = "┆ ", leadmultispace = "┆   " }
-- opt.listchars = { tab = "┊ ", leadmultispace = "┊   " }
-- opt.listchars = { tab = "┇ ", space = "" }

-- NOTE: Set Theme
-- cmd.colorscheme("onedark")
-- cmd.colorscheme("tokyodark")
-- cmd.colorscheme("nordic")
-- cmd.colorscheme("kanagawa") -- NOTE:"kanagawa-dragon", "kanagawa-wave", "kanagawa-lotus"

-- vim.g.ayucolor = "dark" -- "mirage" or "dark"
-- cmd.colorscheme("ayu")
cmd.colorscheme("tokyonight-night") -- NOTE:"tokyonight-night", "tokyonight-storm", "tokyonight-day", "tokyonight-moon"

cmd("set mouse=a")

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = "foldtext() .. \" ...\""
-- NOTE: if don't want to use nvim-ufo virtual_text try uncomment below
opt.foldtext = ""
opt.fillchars = "fold:."

opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4
-- cmd("highlight MatchParen guibg=white guifg=black gui=NONE")
-- Get godot jump when create or clikc script
local gdproj = vim.fs.find('project.godot', { path = vim.fn.getcwd(), upward = true })
if #gdproj > 0 then
	local addr = '/tmp/godot.pipe'
	if vim.uv.os_uname().sysname == "Windows_NT" then
		addr = '127.0.0.1:6004'
		local result = vim.system({ "netstat", "-ano" }, { text = true }):wait()
		if result.code == 0 and result.stdout:find("6004") ~= nil then
			return
		end
	end

	local stats, _, err_name = vim.uv.fs_stat(addr)
	if stats or err_name ~= "ENOENT" then
		return
	end

	vim.fn.serverstart(addr)
end
