local M =
{
	{
		"tiagovla/tokyodark.nvim",
		lazy = true,
		opts = {
			-- custom options here
		},
		config = function()
			require("tokyodark").setup() -- calling setup is optional
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	},
	{ "ayu-theme/ayu-vim", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
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
					all = {
						ui = {
							nontext = "#8aa7cf",
							-- special = "#ff0000",
							bg_p2 = "#313141",
							--"#313141"
						}
					}
				},
			},

		},
	},
	{
		'AlexvZyl/nordic.nvim',
		lazy = true,
		opts = {
			after_palette = function(palette)
				palette.fg_sidebar = "#8aa7cf"
			end,
			bright_border = true,
			reduced_blue = false,
			cursorline = {
				theme = 'light',
				bg = "#292e3b", --#292e3b
				blend = 0,
			},
			override = {
				CursorLineNr = { fg = '#ffc300' },
				MatchParen = { fg = "#ffc900" },
				PmenuKind = { bg = "NONE" },
				Visual = { link = "PmenuSel" },
				VisualNOS = { link = "PmenuSel" },
				-- DevIconDefault = { bg = "inherit" }
			},
			telescope = {
				style = "flat"
			}
		}
	},
	{
		'navarasu/onedark.nvim',
		lazy = true,
		opts = {
			style = 'darker',            -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			highlights = {
				["CursorLine"] = { bg = "#2e3139" }, -- "#2e3139"
				["Comment"] = { fg = "#62697a" }, -- "#575e6e"
				["Conceal"] = { fg = "#ffffff" },
				["WinSeperator"] = { fg = "#ffffff" },
				["@comment"] = { fg = "#62697a" },
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
		}
	}
}
return { M }
