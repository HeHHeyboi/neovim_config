local M =
{
	{ "ayu-theme/ayu-vim", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			compile = true,
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = {
					wave = {},
					lotus = {},
					dragon = {},
					all = {
						ui = {
							-- bg_gutter = "none",
							nontext = "#8aa7cf",
							bg_p2 = "#292e3b"
						}
					}
				},
			},

		},
	},
}
return { M }
