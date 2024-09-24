-- Load your custom Vimscript configuration
local opt = vim.opt
local cmd = vim.cmd
local vimrc = vim.fn.stdpath("config") .. "./Plugin.vim"
vim.cmd.source(vimrc)
if vim.g.vscode then

else
	require('plugin')
	require('keymap')
	--require('netrw')
	require('autocmd')
	local chadtree_settings = {
		["theme.icon_glyph_set"] = "devicons"
		,
		["keymap.tertiary"] = { "<A-t>" }
		,
		["options.follow"] = false
	}
	vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
	-- Set options
	opt.smarttab = true
	opt.encoding = "UTF-8"
	opt.swapfile = false
	opt.cursorline = true

	-- Set colorscheme
	cmd.colorscheme("kanagawa-wave")
	--vim.g.ayucolor = "dark" -- or "mirage" or "dark"
	--vim.cmd("colorscheme ayu")

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

	if vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot') == 1 then
		local addr = './godot.pipe'
		if vim.fn.has 'win64' == 1 then
			addr = '127.0.0.1:6005'
		end
		vim.fn.serverstart(addr)
	end
end
