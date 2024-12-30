if vim.fn.argc() == 0 then
	vim.cmd("Oil")
	-- vim.api.nvim_create_augroup('OpenOil', { clear = true })
	--
	-- vim.api.nvim_create_autocmd('VimEnter', {
	-- 	group = 'OpenOil',
	-- 	pattern = '*',
	-- 	callback = function()
	-- 		vim.defer_fn(function() vim.cmd("e .") end, 10) -- delay execution by 100ms
	-- 	end
	-- })
end
vim.api.nvim_create_augroup('misc_augroup', { clear = true })
local exclude = { "godot", "make" }
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = '*',
	callback = function()
		for _, value in ipairs(exclude) do
			if vim.bo.filetype == value then
				return
			end
		end
		vim.lsp.buf.format()
	end
})
vim.api.nvim_create_autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = 'misc_augroup',
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
