local M = {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },

	version = '1.1.1',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = 'enter',
			['<C-y>'] = { 'select_and_accept' },
			['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
		},
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true
				},
			},
			keymap = {
				preset = 'enter',
				['<C-y>'] = { 'select_and_accept', 'fallback' }
			},
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = false },
			keyword = { range = "prefix" },
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "kind_icon", gap = 1 },
						{ "label",     "label_description", gap = 1 },
					}
				}
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				}
			},
			accept = {
				auto_brackets = { enabled = false }
			}
		},

		-- Default list of enabled providers defined so that you can extend it
		--
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		signature = { enabled = true, window = { border = 'rounded' } },


		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}

return M
