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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gdscript" then
			local name = vim.fn.bufname("%")
			vim.fn.jobstart("gdformat " .. name, {
				on_exit = function(exit_code)
					if exit_code == 0 then
						vim.cmd("edit!") -- Reload file to apply formatting changes
					end
				end
			})
			return
		end
		vim.lsp.buf.format()
	end
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.nu",
	callback = function()
		vim.bo.filetype = "json.nu"
	end,
})
