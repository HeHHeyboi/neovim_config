local M = {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
	config = function()
		local open_trouble = require("trouble.sources.telescope").open
		local actions = require("telescope.actions")
		require("telescope").setup {
			defaults = {
				filesize_limit = 50,
				timeout = 1000,
				preview = { hide_on_startup = true },
				mappings = {
					i = { ["<C-q>"] = open_trouble }, -- Insert mode binding
					n = { ["<C-q>"] = open_trouble,
						["<C-c>"] = actions.close,
						["s"] = actions.toggle_selection + actions.move_selection_next,
						["S"] = actions.toggle_selection + actions.move_selection_previous
					}, -- Normal mode binding
				},
				-- path_display = { "smart" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown {}
				}
			},
			pickers = {
				path_display = { "smart" },
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					-- theme = "dropdown",
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/env/*" },
				},
				buffers = {
					mappings = {
						n = { ["<c-d>"] = actions.delete_buffer + actions.move_to_top, }
					}
				},
			},
		}
		require("telescope").load_extension("ui-select")
	end,

}
-- plugins/telescope.lua:
return { M }
