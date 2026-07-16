vim.pack.add({
	'https://github.com/saghen/blink.lib',
	{ src = "https://github.com/saghen/blink.cmp", version = "cfe100ccac24b0a622d7b9f04aa8c9f3e7624a16" },
	'https://github.com/rafamadriz/friendly-snippets',
})

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
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
		preset = 'default',
		-- ['<C-y>'] = { 'select_and_accept', 'fallback' },
		['<CR>'] = { 'select_and_accept', 'fallback' },
		['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
		['<C-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
		['<C-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
		['<C-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
		['<C-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
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
				preselect = false,
				auto_insert = false,
			}
		},
		accept = {
			auto_brackets = { enabled = false }
		}
	},

	cmdline = {
		enabled = true,
		completion = {
			menu = {
				auto_show = true
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				}
			},
		},
		keymap = {
			preset = 'cmdline',
			['<C-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
			['<C-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
			['<C-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
			['<C-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
			['<C-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			lsp = {
				name      = "LSP",
				module    = "blink.cmp.sources.lsp",
				fallbacks = {}, -- always show buffer
			},
			path = {
				module = 'blink.cmp.sources.path',
				score_offset = 3,
				fallbacks = { 'buffer' },
				opts = {
					trailing_slash = true,
					label_trailing_slash = true,
					get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
					show_hidden_files_by_default = false,
					-- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
					ignore_root_slash = false,
					-- Maximum number of files/directories to return. This limits memory use and responsiveness for very large folders.
					max_entries = 100,
				}
			},

			snippets = {
				module = 'blink.cmp.sources.snippets',
				score_offset = -1, -- receives a -3 from top level snippets.score_offset
			},
			buffer = {
				name         = "Buffer",
				module       = "blink.cmp.sources.buffer",
				score_offset = -5
			}
		}
	},
	signature = { enabled = true, window = { border = 'rounded' } },


	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust" }
})
