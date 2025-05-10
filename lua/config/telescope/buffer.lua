local pickers = require("telescope.pickers")
local from_entry = require("telescope.from_entry")
local utils = require("telescope.utils")
local preview = require("telescope.previewers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local log = require("plenary.log"):new()
log.level = 'debug'
local M = {}
local opts = {
	preview = { hide_on_startup = true },
	show_title = true
}

local displayer = entry_display.create({
	separator = " ",
	items = {
		{ width = 3 }, -- buffer number
		{ width = 4 }, -- info flag
		{ width = 2 }, -- icon
		{ remaining = true } -- filename
	},
})


local function list_buffers_ls_style()
	-- opts = opts or {}
	opts.preview = opts.preview or { hide_on_startup = true }
	opts.show_title = opts.show_title or false
	local buffers = {}

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			local check_oil = string.find(name, "oil")
			name = string.gsub(name, "\\", "/")
			if name ~= "" and check_oil == nil then
				name = vim.fn.fnamemodify(name, ":~:.")
			else
				goto continue
			end
			local flag = ""
			if buf == vim.fn.bufnr("%") then
				flag = "%a "
			elseif buf == vim.fn.bufnr("#") then
				flag = "#h "
			else
				flag = "h "
			end
			local bufnr_str = tostring(buf)
			local modified = vim.bo[buf].modified and "+" or ""
			local readonly = vim.bo[buf].readonly and "-" or ""
			local icon, hl_group = utils.get_devicons(name, opts.disable_devicons)
			icon = icon and (icon .. " ") or ""
			-- local listed = vim.api.nvim_buf_get_option(buf, "buflisted") and " " or " unlisted"

			table.insert(buffers, {
				name = name,
				bufnr = bufnr_str,
				icon = icon,
				hl_group = hl_group,
				flag = flag,
				info = modified .. readonly,
				basename = vim.fs.basename(name),
				ordinal = name .. modified,
			})
			::continue::
		end
	end
	pickers.new(opts, {
		prompt_title = "Buffers (:ls style)",
		finder = finders.new_table {
			results = buffers,
			entry_maker = function(entry)
				return {
					bufnr = tonumber(entry.bufnr),
					ordinal = entry.ordinal,
					basename = entry.basename,
					filename = entry.name,
					display = function()
						return displayer {
							{ entry.bufnr,              "TelescopeResultsNumber" },
							{ entry.flag .. entry.info, "TelescopeResultsComment" },
							{ entry.icon,               entry.hl_group },
							{ entry.name },
						}
					end,
				}
			end,
		},
		sorter = conf.generic_sorter(opts),
		-- previewer = preview.vim_buffer_cat.new(opts),
		-- sorter = conf.file_sorter(opts),
		previewer = preview.new_buffer_previewer({
			-- title = "",
			dyn_title = function(self, entry)
				if opts.show_title then
					return entry.basename
				end
				return ""
			end,
			define_preview = function(self, entry, status)
				preview.buffer_previewer_maker(entry.filename, self.state.bufnr, {
					bufname = self.state.bufname,
					use_ft_detect = true,
				})
			end
		}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.api.nvim_set_current_buf(selection.bufnr)
			end)
			map("n", "<C-d>", actions.delete_buffer)
			return true
		end,
	}):find()
end

M.opts = opts
M.list_buffers_ls_style = list_buffers_ls_style
return M
