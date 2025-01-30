local M = {
	'hrsh7th/nvim-cmp',
	dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
		'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
	event = { "InsertEnter", "CmdlineEnter" },
	opts = function(_, opts)
		opts.sources = opts.sources or {}
		table.insert(opts.sources, {
			name = "lazydev",
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		})
	end,
	config = function()
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require("cmp")
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = 'nvim_lsp_signature_help' },
				{ name = "path" },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
				['<C-g>'] = function()
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end,
				-- C-b (back) C-f (forward) for snippet placeholder navigation.
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
			}),
			view = {
				entries = {
					name = "custom",
					selection_order = "near_cursor",
					follow_cursor = false,
				}
			}
		})


		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "buffer" },
			}),
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end
}

return { M }
