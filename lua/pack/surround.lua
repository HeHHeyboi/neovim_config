require("pack.util")

vim.pack.add({
	{
		src = github('windwp/nvim-autopairs'),
		version = "master"
	},
	{
		src = github("kylechui/nvim-surround"),
		version = vim.version.range("4.x"), -- Use for stability; omit to use `main` branch for the latest features
	}
})

require('nvim-autopairs').setup({
	check_ts = true,
})

require('nvim-surround').setup({})
