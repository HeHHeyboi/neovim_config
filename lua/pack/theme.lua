vim.pack.add({
	"https://github.com/tiagovla/tokyodark.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/ayu-theme/ayu-vim",
	"https://github.com/rebelot/kanagawa.nvim",
	'https://github.com/navarasu/onedark.nvim',
})
-- NOTE: Tokyodark
require("tokyodark").setup() -- calling setup is optional

-- NOTE: Tokyonight
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

require("onedark").setup({
	style = 'darker',                  -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	highlights = {
		["CursorLine"] = { bg = "#2e3139" }, -- "#2e3139"
		["Comment"] = { fg = "#62697a" }, -- "#575e6e"
		["Conceal"] = { fg = "#ffffff" },
		["WinSeperator"] = { fg = "#ffffff" },
		["@comment"] = { fg = "#62697a" },
		["@spell.odin"] = { fg = "#62697a" },
		["@lsp.type.comment"] = { fg = "#575e6e" },
		["CursorLineNr"] = { fg = "#ffc300" },
		["LineNr"] = { fg = "#8aa7cf" },
		["MatchParen"] = { fg = "#ffc300", bg = "NONE" },
		["PMenu"] = { bg = "#17191c" }, -- "#212d40"
		["NormalFloat"] = { bg = "#17191c" }, -- "#15181d","#131a25","#17191c"
		["FloatBorder"] = { bg = "#17191c" },
		["LspReferenceTarget"] = { bg = "#46494f" },

		["DiagnosticVirtualTextError"] = { fg = "#d84752" },
		["DiagnosticVirtualTextWarn"] = { fg = "#e0af68" }, -- Muted gold for warnings
		["DiagnosticVirtualTextInfo"] = { fg = "#4ec1d3" }, -- Muted teal for info
		["DiagnosticVirtualTextHint"] = { fg = "#c769e2" },
	}
})

-- NOTE: Kanagawa
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
