return {
	{
		"williamboman/mason.nvim",
		cond = function()
			return not vim.opt.diff:get()
		end,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		}
	},
}
