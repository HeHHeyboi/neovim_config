if vim.fn.argc() == 0 then
	vim.cmd("Oil")
end

require("config.format")
-- local exclude = { "gdscript", "make" }

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('format_buffer', {}),
	desc = "LSP autocmd",
	callback = function(args)
		local start = vim.uv.hrtime()
		vim.lsp.inlay_hint.enable(false, { bufnr = nil }) -- Enable inlay hints
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('format_buffer', { clear = false }),
				buffer = args.buf,
				callback = function()
					-- local start = vim.uv.hrtime()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
					-- local elapsed_ms = (vim.uv.hrtime() - start) / 1e6
					-- print(elapsed_ms .. " ms")
				end,
			})
		end
	end
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("Format with formatter", { clear = true }),
	pattern = { '*.gd' },
	callback = function()
		local format = Custom_format[vim.bo.filetype]
		if format ~= nil then
			Format_file(format.cmd, format.arg)
		end
	end
})

-- NOTE: when call command after write buffer may cause 'Race condition'
-- so when do something after BufWritePost try call "vim.schedule()" first
--
-- NOTE: autocmd doesn't work when in sandbox
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "save fold",
	callback = function()
		vim.cmd("mksession!")
	end
})

vim.api.nvim_create_autocmd("QuitPre", {
	desc = "Remove view",
	callback = function()
		local cwd = vim.fs.normalize(vim.uv.cwd())
		local session_path = cwd .. "/Session.vim"

		if vim.uv.fs_stat(session_path) then
			vim.fs.rm(session_path)
		end
	end
})

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Update Fold expr",
	callback = function()
		vim.schedule(function()
			vim.cmd("so Session.vim")
		end)
	end
})

vim.api.nvim_create_augroup('goto_prev_pos_from_last_exit', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = 'goto_prev_pos_from_last_exit',
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gitcommit" or vim.wo.diff then
			return
		end
		vim.cmd('silent! normal! g`"zv')
		vim.schedule(function()
			vim.cmd('UfoEnableFold')
		end)
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function()
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#313141" })
	end,
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
