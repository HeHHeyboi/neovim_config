local function line()
	return [[Line:%l|%L]]
end
local function col()
	return [[Col:%c]]
end
local function buffer()
	return [[Buf: %n]]
end
return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup{
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { { "%f%m", color = { fg = '#ffffff', gui = 'bold' } } },
				lualine_x = { 'searchcount', 'fileformat' },
				lualine_y = { 'filetype', col },
				lualine_z = { line }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename', '%m' },
				lualine_x = {}, --'location'
				lualine_y = { col },
				lualine_z = { line }
			},
			tabline = {
			},

			winbar = {
			},
			inactive_winbar = {},
			extensions = {}
			}
		end,
	}
}
