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
			set shell=pwsh
			set shellcmdflag=-Command
			set shellquote=
			set shellxquote=
		endif
	endif
	call plug#begin()

	Plug 'rebelot/kanagawa.nvim'
	"Plug 'ayu-theme/ayu-vim'

	Plug 'jiangmiao/auto-pairs'
	Plug 'rstacruz/vim-closer'
	Plug 'tpope/vim-surround'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	"Plug 'bling/vim-bufferline'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	" Plug 'ryanoasis/vim-devicons' Icons without colours


	Plug 'folke/trouble.nvim'
	Plug 'folke/todo-comments.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope-ui-select.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

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
	"file exploer
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
	Plug 'stevearc/oil.nvim'

	"comment plugin
	Plug 'numToStr/Comment.nvim'

" Somewhere after plug#end()
	call plug#end()
	"highlight Normal guibg=none
	"highlight NonText guibg=none
	"highlight Normal ctermbg=none
	"highlight NonText ctermbg=none
endif


