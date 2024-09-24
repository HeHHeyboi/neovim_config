function _G.checkAtcursor(c)
	vim.cmd("normal! ^")
	local curCol = vim.fn.getcursorcharpos()[3]
	local line = vim.api.nvim_get_current_line()
	local char = line:sub(curCol, curCol)
	local cmd
	print(c)
	print(char)
	if string.find(c, char) ~= nil then
		cmd = "normal! ^df" .. c .. "j"
	else
		cmd = "normal! I" .. c
	end
	vim.cmd(cmd)
end

local function VisualcheckAtcursor(c)
	vim.cmd("normal! I")
	vim.cmd("normal! ^")
	local curCol = vim.fn.getcursorcharpos()[3]
	local line = vim.api.nvim_get_current_line()
	local char = line:sub(curCol, curCol)
	local cmd
	if string.find(c, char) then
		cmd = "'<,'>normal! ^df" .. c
	else
		cmd = "'<,'>normal! I" .. c
	end
	vim.cmd(cmd)
	--vim.cmd("normal! gv")
	--vim.api.nvim_feedkeys("gv", "n", false)
end
if vim.fn.argc() == 0 then
	-- Create an autocommand group to avoid duplication
	vim.api.nvim_create_augroup('OpenOil', { clear = true })

	-- Trigger the command on VimEnter event
	vim.api.nvim_create_autocmd('VimEnter', {
		group = 'OpenOil',
		pattern = '*',
		callback = function()
			vim.defer_fn(function() vim.cmd("Oil .") end, 50) -- delay execution by 100ms
		end
	})
end

--local luaFile = vim.api.nvim_create_augroup("filetype_lua", { clear = true })
--vim.api.nvim_create_autocmd("FileType", {
--pattern = "lua",
--group = luaFile,
--callback = function()
--local keymap = vim.keymap.set
--keymap("n", "<C-k>", function()
--checkAtcursor("--")
--end, { noremap = true })
----keymap("v", "<C-k>", ":'<,'> lua checkAtcursor()<cr>", { noremap = true })
--keymap("v", "<C-k>", function()
--VisualcheckAtcursor("--")
--end, { noremap = true })
--end
--})

vim.api.nvim_command('autocmd BufNewFile,BufRead *.csproj setfiletype csproj')
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = '*',
	callback = function()
		--vim.lsp.buf.format({ async = true })
		vim.lsp.buf.format()
		--vim.cmd("LspRestart")
	end
})
