local M =
{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "gitattributes", "git_config", "git_rebase", "gitcommit", "gdscript", "c_sharp",
					"cpp",
					"java", "c",
					"lua", "vim", "vimdoc", "markdown", "markdown_inline", "go" },

				sync_install = false,
				modules = {},
				ignore_install = {},

				auto_install = false,

				indent = {
					enable = true,
				},

				highlight = {
					enable = true,

					additional_vim_regex_highlighting = false,
				},
			})
		end
	},
	-- {
	-- 	'nvim-treesitter/nvim-treesitter-refactor',
	-- 	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	-- 	config = function()
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		require 'nvim-treesitter.configs'.setup {
	-- 			refactor = {
	-- 				highlight_definitions = { enable = true },
	-- 				highlight_current_scope = { enable = false },
	-- 			}
	-- 		}
	-- 	end
	-- }
}
return M
