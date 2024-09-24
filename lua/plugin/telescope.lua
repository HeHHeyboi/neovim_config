require("telescope").setup {
	defaults = {
		filesize_limit = 50,
		timeout = 1000
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
			}
		}
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
}
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("color")
