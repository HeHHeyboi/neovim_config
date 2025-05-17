local keymap = vim.keymap.set
local telescope = require("telescope.builtin")
require("config.inQuote")
require("config.format")
vim.keymap.del("n", "<leader>q")

keymap("n", "<leader>q", function()
	if vim.wo.diff then
		vim.cmd(":qall")
	else
		vim.cmd(":q")
	end
end)

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
-- local theme = require('telescope.themes').get_dropdown({})
-- NOTE: Telescope
keymap("n", "<C-p>", telescope.find_files, { desc = "Find find" })
-- keymap("n", "<leader>fg", telescope.live_grep, { desc = "Telescope Grep" })
keymap("n", "<leader>fg", require("config.telescope.multigrep").live_multigrep, { desc = "Telescope Grep" })
-- keymap("n", "vb", telescope.buffers, { desc = "View Buffer" })
keymap("n", "vb", require("config.telescope.buffer").list_buffers_ls_style, { desc = "View Buffer" })
keymap("n", "vr", telescope.registers, { desc = "View Register" })
keymap("n", "vm", telescope.marks, { desc = "View Mark" })
keymap("n", "<A-m>", telescope.diagnostics, { desc = "Telescope Diagnostic" })
-- vim.keymap.del("n", "<leader>ds")
keymap("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "Telescope Document Symbols" })
keymap("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "Telescope Workspace symbols" })


-- NOTE: Trouble
keymap("n", "<A-'>", ":Trouble diagnostics toggle focus=true<cr>", { desc = "Toggle Trouble diagnostics" })
--keymap("n", "<leader>'", ":Trouble diagnostics toggle focus=true<cr>", {})
keymap("n", "<leader>tq", ":Trouble qflist toggle focus=true<cr>", { desc = "Trouble quickfix" })
keymap("n", "vtd", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })
keymap("n", "<leader>td", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })

--delete mark
-- keymap("n", "dm", function()
-- 	local mark = vim.fn.nr2char(vim.fn.getchar())
-- 	vim.cmd("delmark " .. mark)
-- end, {})

-- NOTE: Oil.nvim
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- NOTE: Format
keymap("n", "<A-f>", function()
	local format = Custom_format[vim.bo.filetype]
	if format ~= nil then
		Format_file(format.cmd, format.arg)
		return
	end
	vim.lsp.buf.format({ async = true })
end, { silent = true })

--LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("Lsp_keymap", {}),
	desc = "LSP actions",
	callback = function(event)
		local custom_border = { '', '', ' ', ' ' }
		local opts = { buffer = event.buf }
		local function map(key, func)
			vim.keymap.set("n", key, func, opts)
		end

		map("K", function()
			-- vim.lsp.buf.hover({ border = custom_border })
			vim.lsp.buf.hover({ border = "rounded" })
			-- vim.lsp.buf.hover({ border = { '', '' } })
		end)
		-- map("K", vim.lsp.buf.hover)
		map("gD", vim.lsp.buf.declaration)
		--map("n", "gN", vim.diagnostic.goto_next, { buffer = 0, desc = "LSP Next Diagnostic" })
		--map("n", "gP", vim.diagnostic.goto_prev, { buffer = 0, desc = "LSP Previous Diagnostic" })
		-- map("gd", vim.lsp.buf.definition)

		map("gl", vim.diagnostic.open_float)
		map("[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		map("]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		--Telescope
		map("gd", telescope.lsp_definitions)
		map("gi", telescope.lsp_implementations)
		map("go", telescope.lsp_type_definitions)
		map("grr", telescope.lsp_references)

		map("gs", function()
			-- vim.lsp.buf.signature_help({ border = custom_border })
			vim.lsp.buf.hover({ border = "rounded" })
			-- vim.lsp.buf.hover({ border = custom_border })
		end)
		map("<F2>", vim.lsp.buf.rename)
		map("<leader>ca", vim.lsp.buf.code_action)

		keymap({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
})
