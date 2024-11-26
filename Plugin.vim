source ~/.vimrc
if exists('g:vscode')
	source ~/AppData/Local/nvim/vim/keymap.vim

else
	source ~/.vimrc
	source ~/AppData/Local/nvim/vim/vim-airline.vim
	source ~/AppData/Local/nvim/vim/autocmd.vim
	source ~/AppData/Local/nvim/vim/keymap.vim
	source ~/AppData/Local/nvim/vim/tabline.vim
	let g:python3_host_prog = 'C:\Program Files\Python312\python'
	if has("win64") 	
		if executable("pwsh")
			let &shell= executable('pwsh') ? 'pwsh': 'powershell'
			let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
			let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
			let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
			set shellquote= shellxquote=
		endif
	endif
	call plug#begin()

	Plug 'rebelot/kanagawa.nvim'
	Plug 'ayu-theme/ayu-vim'

	Plug 'jiangmiao/auto-pairs'
	Plug 'rstacruz/vim-closer'
	Plug 'tpope/vim-surround'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	"Plug 'bling/vim-bufferline'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	" Plug 'ryanoasis/vim-devicons' Icons without colours


	"diagnostics & to-do
	Plug 'folke/trouble.nvim'
	Plug 'folke/todo-comments.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	"lsp & code completion
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope-ui-select.nvim'

	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'

	Plug 'folke/neodev.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'

	Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
	Plug 'saadparwaiz1/cmp_luasnip'
	" Plug 'mfussenegger/nvim-jdtls'

	"file exploer
	" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
	Plug 'stevearc/oil.nvim'
	Plug 'nanotee/sqls.nvim'

	"comment plugin
	Plug 'numToStr/Comment.nvim'
	"render markdown documation window
	" Plug 'folke/noice.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'mfussenegger/nvim-dap'
	" Plug 'tpope/vim-dadbod'
	" Plug 'kristijanhusak/vim-dadbod-ui'

	call plug#end()
endif
