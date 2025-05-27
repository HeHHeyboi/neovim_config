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
	{
		"williamboman/mason-lspconfig.nvim",
		cond = function()
			return not vim.opt.diff:get()
		end,
		opts = {
			ensure_installed = { "lua_ls", "gopls", "clangd" },
			automatic_installation = false
		}
	},

}
