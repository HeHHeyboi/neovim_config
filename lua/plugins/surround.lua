return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {
			check_ts = true
		}
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {}
	}
}
