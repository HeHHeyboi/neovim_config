local keymap = vim.keymap.set
require("inQuote")

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
--test keymap

-- keymap({ "n", "i", "v" }, "gm", function()
-- 	print(vim.fn.mode())
-- end, { noremap = true })
local telescope = require("telescope.builtin")
local luasnip = require('luasnip')
local function is_quickfix_open()
	-- Iterate over all windows
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		-- Get the buffer associated with the window
		local buf = vim.api.nvim_win_get_buf(win)
		-- Check the buffer type
		if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
			return true
		end
	end
	return false
end

--oprator pending

-- luasnip
keymap("i", "<Tab>", function()
	if luasnip.expand_or_jumpable() then
		return "<Plug>luasnip-expand-or-jump"
	else
		return "<Tab>"
	end
end, { expr = true, silent = true, desc = "Use tab to select next" })

keymap("i", "<S-Tab>", function()
	luasnip.jump(-1)
end, { silent = true, desc = "Use tab to select previous" })

keymap("s", "<Tab>", function()
	luasnip.jump(1)
end, { silent = true })

keymap("s", "<S-Tab>", function()
	luasnip.jump(-1)
end, { silent = true })

-- telescope
keymap("n", "<C-p>", telescope.find_files, { desc = "Find find" })
keymap("n", "<leader>fg", telescope.live_grep, { desc = "Telescope Grep" })
keymap("n", "vb", telescope.buffers, { desc = "View Buffer" })
keymap("n", "vr", telescope.registers, { desc = "View Register" })
keymap("n", "vm", telescope.marks, { desc = "View Mark" })
keymap("n", "<leader>ds", telescope.lsp_document_symbols, {})
keymap("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, {})
keymap("n", "<A-m>", telescope.diagnostics, {})
--keymap("n", "<leader>tq", function()
--if is_quickfix_open() then
--vim.cmd('cclose')
--else
--vim.cmd('copen')
--end
--end, {})
--CHADtree
keymap("n", "<C-b>", ":CHADopen<CR>", { desc = "Open File explorer on right(CHADtree)" })

--Trouble
keymap("n", "<A-'>", ":Trouble diagnostics toggle focus=true<cr>", { desc = "Toggle diagnostics" })
--keymap("n", "<leader>'", ":Trouble diagnostics toggle focus=true<cr>", {})
keymap("n", "<leader>tq", ":Trouble qflist toggle focus=true<cr>", { desc = "Trouble quickfix" })
keymap("n", "vtd", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })
keymap("n", "<leader>td", ":TodoTrouble<cr>", { desc = "open Todo with Trouble" })

--delete mark
keymap("n", "dm", function()
	local mark = vim.fn.nr2char(vim.fn.getchar())
	vim.cmd("delmark " .. mark)
end, {})

--Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<C-e>", "<cmd>Oil<CR>", { desc = "Open current dir" })

--LSP format and linter
keymap("n", "<A-f>", function()
	if vim.bo.filetype == "gdscript" then
		-- vim.cmd("write")
		-- vim.cmd("!gdformat " .. name)
		local name = vim.fn.bufname("%")
		vim.fn.jobstart("gdformat " .. name, {
			on_exit = function()
				vim.cmd("edit!")
			end
		})
		return
	end
	vim.lsp.buf.format({ buffer = 0, async = true })
end, { silent = true })
--LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		local function map(key, func)
			vim.keymap.set("n", key, func, opts)
		end

		map("K", function()
			vim.lsp.buf.hover()
		end)
		map("gD", function()
			vim.lsp.buf.declaration()
		end)
		--map("n", "gN", vim.diagnostic.goto_next, { buffer = 0, desc = "LSP Next Diagnostic" })
		--map("n", "gP", vim.diagnostic.goto_prev, { buffer = 0, desc = "LSP Previous Diagnostic" })
		-- map("gd", vim.lsp.buf.definition)

		map("gl", function() vim.diagnostic.open_float() end)
		-- map("n", "[d", vim.diagnostic.goto_prev())
		-- map("n", "]d", vim.diagnostic.goto_next())
		--Telescope
		map("gd", telescope.lsp_definitions)
		map("gi", telescope.lsp_implementations)
		map("go", telescope.lsp_type_definitions)
		map("gr", telescope.lsp_references)

		map("gs", function()
			vim.lsp.buf.signature_help()
		end)
		map("<F2>", function()
			vim.lsp.buf.rename()
		end)
		map("<leader>ca", function()
			vim.lsp.buf.code_action()
		end)

		keymap({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
