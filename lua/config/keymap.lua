---@diagnostic disable: deprecated
local keymap = vim.keymap.set
local telescope = require("telescope.builtin")
require("config.inQuote")
require("config.global")

keymap("o", 'in"', function()
	MoveToNextQuote("\"", 'f', 'i')
end, {})
keymap("o", "in'", function()
	MoveToNextQuote("'", 'f', 'i')
end, {})
keymap("o", 'an"', function()
	MoveToNextQuote("\"", 'f', 'a')
end, {})
keymap("o", "an'", function()
	MoveToNextQuote("'", "f", "a")
end, {})
keymap("o", 'il"', function()
	MoveToNextQuote("\"", "F", 'i')
end, {})
keymap("o", "il'", function()
	MoveToNextQuote("'", 'F', 'i')
end, {})
keymap("o", 'al"', function()
	MoveToNextQuote("\"", 'F', 'a')
end, {})
keymap("o", "al'", function()
	MoveToNextQuote("'", 'F', 'a')
end, {})
keymap("o", "L", "g_", {})
keymap("o", "H", "^", {})

-- NOTE: split buffer
keymap("n", "<leader>vl", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("rightbelow vsplit " .. bufname)
end, { desc = "Vsplit buffer to right" })
keymap("n", "<leader>vh", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("leftabove vsplit " .. bufname)
end, { desc = "Vsplit buffer to left" })
keymap("n", "<leader>vv", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("leftabove vsplit " .. bufname)
end, { desc = "Vsplit buffer" })
keymap("n", "<leader>sj", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("belowright split " .. bufname)
end)
keymap("n", "<leader>sk", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("topleft split " .. bufname)
end)
keymap("n", "<leader>ss", function()
	local bufname = vim.fn.bufname("#")
	vim.cmd("belowright split " .. bufname)
end)

-- NOTE: Telescope
keymap("n", "<C-p>", telescope.find_files, { desc = "Find find" })
-- keymap("n", "<leader>fg", telescope.live_grep, { desc = "Telescope Grep" })
keymap("n", "<leader>fg", require("config.telescope.multigrep").live_multigrep, { desc = "Telescope Grep" })
keymap("n", "vb", telescope.buffers, { desc = "View Buffer" })
keymap("n", "vr", telescope.registers, { desc = "View Register" })
keymap("n", "vm", telescope.marks, { desc = "View Mark" })
keymap("n", "<leader>ds", telescope.lsp_document_symbols, {})
keymap("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, {})
keymap("n", "<A-m>", telescope.diagnostics, {})

--CHADtree
keymap("n", "<C-b>", ":CHADopen<CR>", { desc = "Open File explorer on right(CHADtree)" })

--Trouble
keymap("n", "<A-'>", ":Trouble diagnostics toggle focus=true<cr>", { desc = "Toggle diagnostics" })
--keymap("n", "<leader>'", ":Trouble diagnostics toggle focus=true<cr>", {})
keymap("n", "<leader>tq", ":Trouble qflist toggle focus=true<cr>", { desc = "Trouble quickfix" })
keymap("n", "vtd", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })
keymap("n", "<leader>td", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })

--delete mark
-- keymap("n", "dm", function()
-- 	local mark = vim.fn.nr2char(vim.fn.getchar())
-- 	vim.cmd("delmark " .. mark)
-- end, {})

--Oil.nvim
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local format = function(filetype, formatter)
	local name = vim.fn.bufname("%")
	local job_format = vim.fn.jobstart(formatter .. " " .. name, {
		on_exit = function(exit_code)
			vim.cmd("edit!")
		end
	})
	vim.fn.jobwait({ job_format })
end
-- NOTE: Format and linter
local custom_format = {
	hurl = {
		cmd = "hurlfmt",
		arg = "--in-place"
	},
	gdscript = {
		cmd = "gdformat",
		arg = ""
	}
}
keymap("n", "<A-f>", function()
	local format = custom_format[vim.bo.filetype]
	if format ~= nil then
		Format_file(format.cmd, format.arg)
	end
	vim.lsp.buf.format({ async = true })
end, { silent = true })

--LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		if vim.opt.diff:get() then
			return
		end
		local opts = { buffer = event.buf }
		local function map(key, func)
			vim.keymap.set("n", key, func, opts)
		end

		map("K", vim.lsp.buf.hover)
		map("gD", vim.lsp.buf.declaration)
		--map("n", "gN", vim.diagnostic.goto_next, { buffer = 0, desc = "LSP Next Diagnostic" })
		--map("n", "gP", vim.diagnostic.goto_prev, { buffer = 0, desc = "LSP Previous Diagnostic" })
		-- map("gd", vim.lsp.buf.definition)

		map("gl", vim.diagnostic.open_float)
		map("[d", vim.diagnostic.goto_prev)
		map("]d", vim.diagnostic.goto_next)
		--Telescope
		map("gd", telescope.lsp_definitions)
		map("gi", telescope.lsp_implementations)
		map("go", telescope.lsp_type_definitions)
		map("grr", telescope.lsp_references)

		map("gs", vim.lsp.buf.signature_help)
		map("<F2>", vim.lsp.buf.rename)
		map("<leader>ca", vim.lsp.buf.code_action)

		keymap({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
})
