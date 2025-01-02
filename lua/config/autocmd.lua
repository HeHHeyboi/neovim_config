if vim.fn.argc() == 0 then
	vim.cmd("Oil")
end
require("config.global")
local exclude = { "gdscript", "make" }
local custom_format = {
	hurl = {
		cmd = "hurlfmt",
		arg = "--in-place"
	}
}
local format_group = vim.api.nvim_create_augroup('FormatFile', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = '*',
	callback = function()
		local filetype = vim.bo.filetype
		for _, value in ipairs(exclude) do
			if filetype == value then
				return
			end
		end
		if custom_format[filetype] ~= nil then
			return
		end
		vim.lsp.buf.format()
	end
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = format_group,
	pattern = { '*.hurl' },
	callback = function()
		local format = custom_format[vim.bo.filetype]
		if format ~= nil then
			Format_file(format.cmd, format.arg)
		end
	end
})
vim.api.nvim_create_augroup('goto_prev_pos_from_last_exit', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = 'goto_prev_pos_from_last_exit',
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gitcommit" then
			print("this is gitcommit")
			return
		end
		vim.cmd('silent! normal! g`"zv')
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP autocmd",
	callback = function()
		if vim.bo.filetype == "cpp" then
			-- vim.lsp.inlay_hint.enable(false, { bufnr = nil }) -- Enable inlay hints
			return
		end
		vim.lsp.inlay_hint.enable(true, { bufnr = nil }) -- Enable inlay hints
	end
})
