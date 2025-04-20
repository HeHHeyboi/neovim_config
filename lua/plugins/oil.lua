return
{
	'stevearc/oil.nvim',
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	cond = function()
		return not vim.opt.diff:get()
	end,
	opts = {
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
			{ "icon", add_padding = false },
			-- "type",
			-- "permissions",
			-- "size",
			-- "atime",
		},
		keymaps = {
			["cd"] = { "actions.cd", desc = ":Change working directory", mode = "n" }
		}
	},
	-- Optional dependencies
	--dependencies = { { "echasnovski/mini.icons", opts = {} } },

}
