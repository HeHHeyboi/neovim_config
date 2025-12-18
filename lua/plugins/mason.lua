return {
	{
		"williamboman/mason.nvim",
		cond = function()
			return not vim.opt.diff:get()
		end,
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
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
