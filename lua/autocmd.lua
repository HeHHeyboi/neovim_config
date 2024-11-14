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

vim.api.nvim_create_augroup('misc_augroup', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gdscript" then
			return
		end
		vim.lsp.buf.format()
	end
})
vim.api.nvim_create_autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = 'misc_augroup',
	pattern = '*',
	command = 'silent! normal! g`"zv'
})
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = '*.gd',
-- 	callback = function()
-- 		local name = vim.fn.bufname("%")
-- 		-- vim.cmd("write")
-- 		local job_format = vim.fn.jobstart("gdformat " .. name, {
-- 			on_exit = function(exit_code)
-- 				vim.cmd("edit!")
-- 			end
-- 		})
-- 		vim.fn.jobwait({ job_format })
-- 	end
-- })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.nu",
	callback = function()
		vim.bo.filetype = "json.nu"
	end,
})
