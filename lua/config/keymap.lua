local keymap = vim.keymap.set
require("config.inQuote")
require("config.format")
vim.keymap.del("n", "<leader>q")
vim.keymap.del("n", "<leader>w")

keymap("n", "<leader>q", function()
	if vim.wo.diff then
		vim.cmd("qall")
	else
		vim.cmd("q")
	end
end)

keymap("n", "<leader>w", function()
	vim.cmd("w")
end, { silent = true })

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

-- NOTE: Turn off plugin when in diffmode
if vim.o.diff then
	return
end

local setup_telescope = require("pack.telescope")
local setup_oil = require("pack.oil")
local trouble = require("trouble")

local function tpick(name)
	return function()
		setup_telescope()
		require("telescope.builtin")[name]()
	end
end

-- NOTE: Telescope
keymap("n", "<C-p>",      tpick("find_files"),                    { desc = "Find files" })
keymap("n", "vr",         tpick("registers"),                     { desc = "View Register" })
keymap("n", "vm",         tpick("marks"),                         { desc = "View Mark" })
keymap("n", "<A-m>",      tpick("diagnostics"),                   { desc = "Telescope Diagnostic" })
keymap("n", "<leader>ds", tpick("lsp_document_symbols"),          { desc = "Telescope Document Symbols" })
keymap("n", "<leader>ws", tpick("lsp_dynamic_workspace_symbols"), { desc = "Telescope Workspace symbols" })
keymap("n", "<leader>fg", function()
	setup_telescope()
	require("config.telescope.multigrep").live_multigrep()
end, { desc = "Telescope Grep" })
keymap("n", "vb", function()
	setup_telescope()
	require("config.telescope.buffer").list_buffers_ls_style()
end, { desc = "View Buffer" })


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
keymap("n", "-", function()
	setup_oil()
	vim.cmd("Oil")
end, { desc = "Open parent directory" })

-- NOTE: Format
-- keymap("n", "<A-f>", function()
-- 	local format = Custom_format[vim.bo.filetype]
-- 	if format ~= nil then
-- 		Format_file(format.cmd, format.arg)
-- 		return
-- 	end
-- 	vim.lsp.buf.format({ async = true })
-- end, { silent = true })
keymap("n", "<A-f>", function()
	require("conform").format({ lsp_format = "fallback" }, function(err, did_edit)
		local name = vim.fn.bufname("%")
		vim.notify("format " .. name .. " success", vim.log.levels.INFO)
	end)
end, { silent = true })

--LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("Lsp_keymap", {}),
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		local function map(key, func)
			vim.keymap.set("n", key, func, opts)
		end

		map("K",   function() vim.lsp.buf.hover({ border = "rounded" }) end)
		map("gD",  vim.lsp.buf.declaration)
		map("gl",  vim.diagnostic.open_float)
		map("[d",  function() vim.diagnostic.jump({ count = 1,  float = true }) end)
		map("]d",  function() vim.diagnostic.jump({ count = -1, float = true }) end)
		map("gd",  tpick("lsp_definitions"))
		map("gi",  tpick("lsp_implementations"))
		map("go",  tpick("lsp_type_definitions"))
		map("grr", function()
			if vim.o.diff then return end
			trouble.open("lsp_references")
		end)
		map("gs", function() vim.lsp.buf.signature_help({ border = "rounded" }) end)
		map("<F2>", vim.lsp.buf.rename)
		map("<leader>ca", vim.lsp.buf.code_action)

		keymap("i", "<C-s>", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end)
		keymap({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
})
