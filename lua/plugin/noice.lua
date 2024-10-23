require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	messages = {
		enabled = false
	},
	popupmenu = {
		enabled = false
	},
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		-- view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		view = "cmdline",
		format = {
			-- search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
			-- search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
		}
	},
	notify = {
		enabled = false,
	},
	presets = {
		bottom_search = false,   -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = false, -- long messages will be sent to a split
		inc_rename = false,      -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true,   -- add a border to hover docs and signature help
	},
})
