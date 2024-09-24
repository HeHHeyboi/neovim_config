require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
		natural_order = true,
	},
	win_options = {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		-- spell = false,
		-- list = false,
		-- conceallevel = 3,
		-- concealcursor = "nvic",
	},
	keymaps_help = {
		border = "rounded",
	},
	columns = {
		"icon",
		-- "type",
		-- "permissions",
		-- "size",
		-- "atime",
	},
})
