if vim.fn.argc() == 0 then
	vim.cmd("Oil")
end

require("config.format")
-- local exclude = { "gdscript", "make" }

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('format_buffer', {}),
	desc = "LSP autocmd",
	callback = function(args)
		vim.lsp.inlay_hint.enable(false, { bufnr = nil }) -- Enable inlay hints
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('format_buffer', { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = format_group,
	pattern = { '*.gd' },
	callback = function()
		local format = Custom_format[vim.bo.filetype]
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
		if vim.bo.filetype == "gitcommit" or vim.wo.diff then
			print("Git commit file or git diff")
			return
		end
		vim.cmd('silent! normal! g`"zv')
	end
})


-- local format_group = vim.api.nvim_create_augroup('FormatFile', { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = format_group,
-- 	pattern = '*',
-- 	callback = function()
-- 		local filetype = vim.bo.filetype
-- 		for _, value in ipairs(exclude) do
-- 			if filetype == value then
-- 				return
-- 			end
-- 		end
-- 		if Custom_format[filetype] ~= nil then
-- 			return
-- 		end
-- 		vim.lsp.buf.format()
-- 	end
-- })
