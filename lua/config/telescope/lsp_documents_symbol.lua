local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values
local M = {}

-- Highlight groups per LSP symbol kind (mirrors telescope's built-in table).
local type_highlight = {
	["Class"] = "TelescopeResultsClass",
	["Constant"] = "TelescopeResultsConstant",
	["Field"] = "TelescopeResultsField",
	["Function"] = "TelescopeResultsFunction",
	["Method"] = "TelescopeResultsMethod",
	["Property"] = "TelescopeResultsOperator",
	["Struct"] = "TelescopeResultsStruct",
	["Variable"] = "TelescopeResultsVariable",
}

-- Entry maker that keeps the symbol name on the left and pins the symbol type
-- to the right edge. The name column width is resolved dynamically from the
-- results window width, so the type column keeps its fixed width and stays
-- visible even when the window shrinks.
local function gen_from_lsp_symbols(opts)
	opts = opts or {}
	local type_width = opts.symbol_type_width or 11

	local displayer = entry_display.create({
		separator = " ",
		hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
		items = {
			-- Name: take all remaining space (cols - type - separator).
			{ width = function(_, cols) return math.max(1, cols - type_width - 1) end },
			-- { width = opts.bufnr_width },
			-- Type: fixed width.
			{ width = type_width },
		},
	})

	local make_display = function(entry)
		return displayer({
			entry.symbol_name,
			{ entry.symbol_type:lower(), type_highlight[entry.symbol_type] },
		})
	end

	return function(entry)
		local symbol_type, symbol_name = entry.text:match("%[(.+)%]%s+(.*)")
		return make_entry.set_default_entry_mt({
			value = entry,
			ordinal = (symbol_name or entry.text) .. " " .. (symbol_type or "unknown"),
			display = make_display,

			filename = entry.filename,
			lnum = entry.lnum,
			col = entry.col,
			symbol_name = symbol_name or entry.text,
			symbol_type = symbol_type or "unknown",
			start = entry.start,
			finish = entry.finish,
		}, opts)
	end
end

-- Basic picker over the current buffer's LSP document symbols.
local function lsp_document_symbols(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

	local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

	vim.lsp.buf_request_all(bufnr, "textDocument/documentSymbol", params, function(results)
		local symbols = {}
		for _, resp in pairs(results) do
			if resp.result then
				vim.list_extend(symbols, resp.result)
			end
		end

		if vim.tbl_isempty(symbols) then
			vim.notify("No LSP document symbols found", vim.log.levels.WARN)
			return
		end

		-- Flatten LSP DocumentSymbol[] / SymbolInformation[] into telescope entries.
		local items = vim.lsp.util.symbols_to_items(symbols, bufnr, 'utf-8') or {}

		pickers.new(opts, {
			prompt_title = "LSP Document Symbols",
			finder = finders.new_table {
				results = items,
				entry_maker = opts.entry_maker or gen_from_lsp_symbols(opts),
			},
			sorter = conf.generic_sorter(opts),
			previewer = conf.qflist_previewer(opts),
		}):find()
	end)
end

M.gen_from_lsp_symbols = gen_from_lsp_symbols
M.lsp_document_symbols = lsp_document_symbols

return M
