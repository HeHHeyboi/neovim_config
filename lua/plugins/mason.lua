return {
	{
		"williamboman/mason.nvim",
		cond = function()
			return not vim.opt.diff:get()
		end,
		config = function()
			require("mason").setup {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			}
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		cond = function()
			return not vim.opt.diff:get()
		end,
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "gopls", "clangd" },
				automatic_installation = false
			}
		end
	},

}
