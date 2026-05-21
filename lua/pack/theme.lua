vim.pack.add({
	"https://github.com/tiagovla/tokyodark.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/ayu-theme/ayu-vim",
	"https://github.com/rebelot/kanagawa.nvim",
	'https://github.com/AlexvZyl/nordic.nvim',
	'https://github.com/navarasu/onedark.nvim',
})
require("tokyodark").setup() -- calling setup is optional
require("tokyonight").setup({
	on_highlights = function(hl, c)
		local CursorLineNr_fg = "#ffc300"
		-- local LineNr_fg = "#a9b1d6"
		local LineNr_fg = "#8aa7cf"
		hl.LineNr = {
			fg = CursorLineNr_fg,
		}
		hl.LineNrAbove = {
			fg = LineNr_fg,
		}
		hl.LineNrBelow = {
			fg = LineNr_fg,
		}
		hl.Whitespace = {
			fg = "#35354f"
		}
	end
})

require("kanagawa").setup({
	compile = true,
	overrides = function(colors)
		return {
			["@lsp.type.modifier.java"]           = { link = "@keyword" },
			["@lsp.typemod.class.readonly.java"]  = { link = "@type" },
			["@lsp.typemod.property.public.java"] = { link = "@variable.member" },
			-- ["TelescopeSelection"]                = { bg = "#313141", link = "" }, -- "#2e3139"
		}
	end,
	colors = { -- add/modify theme and palette colors
		theme = {
			wave = {
				ui = {
					nontext = "#8aa7cf",
					-- special = "#ff0000",
					bg_p2 = "#313141",
					--"#313141"
				}
			},
			dragon = {
				ui = {
					nontext = "#c5c9c5",
					-- special = "#ff0000",
					-- bg_p2 = "#313141",
					--"#313141"
				}
			}
		},
	},

})
