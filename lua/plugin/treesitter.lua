require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "git_rebase", "gitcommit", "gdscript", "c_sharp", "cpp", "java", "c", "lua", "vim", "vimdoc", "markdown_inline", "markdown", "go" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	indent = {
		enable = true,
	},

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
}
