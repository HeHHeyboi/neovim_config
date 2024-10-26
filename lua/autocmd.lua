if vim.fn.argc() == 0 then
	vim.api.nvim_create_augroup('OpenOil', { clear = true })

	vim.api.nvim_create_autocmd('VimEnter', {
		group = 'OpenOil',
		pattern = '*',
		callback = function()
			vim.defer_fn(function() vim.cmd("Oil .") end, 10) -- delay execution by 100ms
		end
	})
end

vim.api.nvim_command('autocmd BufNewFile,BufRead *.csproj setfiletype csproj')
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = '*',
	callback = function()
		vim.lsp.buf.format()
	end
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.nu",
	callback = function()
		vim.bo.filetype = "json.nu"
	end,
})
