return {
	{
		'mfussenegger/nvim-jdtls',
		cond = function()
			return not vim.wo.diff
		end,
	},
	{
		"seblyng/roslyn.nvim",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		cond = function()
			return not vim.wo.diff
		end,
		opts = {
			-- your configuration comes here; leave empty for default settings
		},
	}
}
