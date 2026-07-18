vim.pack.add({
	"https://github.com/tiagovla/tokyodark.nvim",
	"https://github.com/folke/tokyonight.nvim",
	-- "https://github.com/ayu-theme/ayu-vim",
	"https://github.com/rebelot/kanagawa.nvim",
	'https://github.com/navarasu/onedark.nvim',
})
-- NOTE: Tokyodark
require("tokyodark").setup() -- calling setup is optional

local CursorLineNr = "#ffc300"
-- local CursorLineNr = "#fff8e0"
-- local CursorLineNr = "#ffe799"
-- local LineNr = "#8aa7cf"
local LineNr = "#6d84a3"

-- NOTE: Tokyonight
require("tokyonight").setup({
	on_highlights = function(hl, c)
		hl.LineNr = {
			fg = CursorLineNr,
		}
		hl.LineNrAbove = {
			fg = LineNr,
		}
		hl.LineNrBelow = {
			fg = LineNr,
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
		["CursorLineNr"] = { fg = CursorLineNr },
		["LineNr"] = { fg = LineNr },
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
			["CursorLineNr"]                      = { fg = CursorLineNr, bold = true },
			-- ["TelescopeSelection"]                = { bg = "#313141", link = "" }, -- "#2e3139"
		}
	end,
	colors = { -- add/modify theme and palette colors
		theme = {
			wave = {
				ui = {
					nontext = LineNr,
					-- bg_gutter = "#ffffff",
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
