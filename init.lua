-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "./Plugin.vim"
vim.cmd.source(vimrc)
if vim.g.vscode then
	require('vscode-keymap')
else
	require('plugin')
	require('keymap')
	--require('netrw')
	require('neovide')
	require('autocmd')
	-- local chadtree_settings = {
	-- ["theme.icon_glyph_set"] = "devicons"
	-- ,
	-- ["keymap.tertiary"] = { "<A-t>" }
	-- ,
	-- ["options.follow"] = false
	-- }
	-- vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
	-- Set options
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
	cmd.colorscheme("kanagawa-wave")
	-- cmd.colorscheme("kanagawa-dragon")
	-- vim.g.ayucolor = "mirage" -- or "mirage" or "dark"
	-- vim.cmd("colorscheme ayu")

	cmd("set mouse=a")
	-- Highlight LineNr
	cmd("hi CursorLine   cterm=NONE guibg=#282735 guifg=NONE")
	cmd("highlight LineNr guifg=#8aa7cf")

	cmd("set foldmethod=expr")
	cmd("set foldexpr=nvim_treesitter#foldexpr()")
	cmd("set nofoldenable")
	cmd("set foldlevel=999")
	cmd("highlight TabLine guibg=#3E4452 guifg=#ABB2BF")
	cmd("highlight TabLineSel guibg=#61AFEF guifg=#282C34 gui=bold")
	cmd("highlight TabLineFill guibg=#282C34 guifg=#ABB2BF")
end
