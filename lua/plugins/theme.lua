local M =
{
	{ "ayu-theme/ayu-vim", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			compile = true,
			colors = { -- add/modify theme and palette colors
				theme = {
					all = {
						ui = {
							nontext = "#8aa7cf",
							-- bg_p2 = "#484861"
							bg_p2 = "#313141"
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
			reduced_blue = true,
			cursorline = {
				theme = 'light',
				bg = "#292e3b",
				blend = 0.8,
			},
			override = {
				CursorLineNr = { fg = '#ffc300' },
				MatchParen = { fg = "#ffc900" }
			},
			telescope = {
				style = "classic"
			}
		}
	},
	{
		'navarasu/onedark.nvim',
		lazy = true,
		opts = {
			style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			highlights = {
				["CursorLine"] = { bg = "#2e3139" },
				["CursorLineNr"] = { fg = "#ffc300" },
				["LineNr"] = { fg = "#8aa7cf" },
				["MatchParen"] = { fg = "#ffc300", bg = "NONE" },
				["PMenu"] = { bg = "#15181d" },
				["NormalFloat"] = { bg = "#15181d" },
				["FloatBorder"] = { bg = "#15181d" },
				-- ["@lsp.type.comment"] = { fg = "#5c6d8f" }
			}
		}
	}
}
return { M }
