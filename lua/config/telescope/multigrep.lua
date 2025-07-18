local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local log = require("plenary.log"):new()
log.level = 'debug'
local M = {}

local live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.fn.getcwd()

	local finder = finders.new_async_job {
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				vim.notify("Please provide a search term", vim.log.levels.WARN)
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg", "--hidden", "--glob=!.git/*" } -- Default options
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end
			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end
			local command = {
				args, { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			}
			-- log.debug(vim.iter(command):flatten():totable())
			return vim.iter(command):flatten():totable()
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	}

	pickers.new(opts, {
		prompt_title = "Multi Grep",
		finder = finder,
		previewer = conf.grep_previewer(opts),
		sorter = require("telescope.sorters").empty(),
	}):find()
end

-- M.setup = function()
-- 	vim.keymap.set("n", "<leader>mg", live_multigrep, { desc = "Live Multi-Grep" })
-- end

M.live_multigrep = live_multigrep

return M
