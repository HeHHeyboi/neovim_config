return {
	{
		'mfussenegger/nvim-jdtls',
		cond = function()
			return not vim.wo.diff
		end,
	},
	{
		"seblyng/roslyn.nvim",
		cond = function()
			return not vim.wo.diff
		end,
		enabled = true,
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {
			broad_search = true
		},
	}
}
