-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "./config.vim"
vim.cmd.source(vimrc)
if vim.g.vscode then
	require('config.vscode-keymap')
else
	require('config.lazy')
	require('config.keymap')
	require('config.neovide')
	require('config.autocmd')
	opt.smarttab = true
	opt.encoding = "UTF-8"
	opt.swapfile = false
	opt.cursorline = true
	opt.list = true
	-- opt.listchars = { tab = "| " }
	opt.listchars = { tab = "┆ " }

	-- opt.listchars = { tab = "┇ " }
	--
	-- NOTE: Select colorscheme
	-- cmd.colorscheme("kanagawa-wave")
	-- cmd.colorscheme("kanagawa-dragon")
	vim.g.ayucolor = "mirage" -- "mirage" or "dark"
	cmd.colorscheme("ayu")

	cmd("set mouse=a")
	-- NOTE: Highlight LineNr for kanagawa
	-- cmd("hi CursorLine   cterm=NONE guibg=#2e3646 guifg=NONE")
	-- 252a35, 2e3646, 2a313d, 282735

	-- NOTE: Highlight LineNr for ayu-mirage
	-- cmd("hi CursorLine   cterm=NONE guibg=#292f3e guifg=NONE")
	cmd("hi CursorLine   cterm=NONE guibg=#2d3344 guifg=NONE")
	-- cmd("hi CursorLine   cterm=NONE guibg=#343b4d guifg=NONE")
	-- cmd("hi CursorLine   cterm=NONE guibg=#3a4256 guifg=NONE")
	-- cmd("hi CursorLine   cterm=NONE guibg=#313847 guifg=NONE ") -- or 292f3e, 2d3344, 343b4d,3a425h,313847

	cmd("hi CursorLineNr cterm=NONE guifg=#ffc300 guibg=NONE gui=bold")
	cmd("highlight LineNr guifg=#8aa7cf")

	cmd("set foldmethod=expr")
	cmd("set foldexpr=nvim_treesitter#foldexpr()")
	cmd("set nofoldenable")
	cmd("set foldlevel=999")
	cmd("highlight TabLine guibg=#3E4452 guifg=#ABB2BF")
	cmd("highlight TabLineSel guibg=#61AFEF guifg=#282C34 gui=bold")
	cmd("highlight TabLineFill guibg=#282C34 guifg=#ABB2BF")
end
