if vim.fn.argc() == 0 then
	vim.cmd("Oil")
end

require("config.format")
local exclude_semantic = {}




-- NOTE: when call command after write buffer may cause 'Race condition'
-- so when do something after BufWritePost try call "vim.schedule()" first
--
-- NOTE: autocmd doesn't work when in sandbox
vim.api.nvim_create_autocmd("QuitPre", {
	desc = "Remove view",
	callback = function()
		local view_dir = vim.fs.normalize(vim.o.viewdir)

		if vim.uv.fs_stat(view_dir) ~= nil then
			vim.fs.rm(view_dir, { recursive = true })
		end
	end
})

vim.api.nvim_create_augroup('goto_prev_pos_from_last_exit', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = 'goto_prev_pos_from_last_exit',
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gitcommit" or vim.wo.diff or vim.bo.filetype == "help" or vim.bo.filetype == "oil" then
			return
		end
		vim.cmd('silent! normal! g`"zv')
		-- vim.cmd('UfoEnableFold')
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
