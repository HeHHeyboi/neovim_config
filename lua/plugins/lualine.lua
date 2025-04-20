local function line()
	return [[Line:%l|%L]]
end
local function col()
	return [[Col:%c]]
end
local function mode()
	local m = vim.fn.mode()
	local mapMode = {
		n = "N",
		i = "I",
		v = "V",
		V = "V-l",
		[""] = "V-b",
		R = "R",
		c = "Cmd",
		t = "Term",
	}
	return mapMode[m]
end
local M = {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
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
		},
		sections = {
			-- lualine_a = { 'mode' },
			lualine_a = { mode },
			lualine_b = { { 'branch', color = {} }, 'diff', 'diagnostics' },
			-- lualine_c = { { "%f%m", color = { fg = '#ffffff', gui = 'bold' } } },
			lualine_c = { { 'filename', file_staus = true, path = 1, color = { fg = '#ffffff', gui = '' } } },
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
}
return { M }
