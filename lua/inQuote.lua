local function is_in_quote(c)
	local line = vim.api.nvim_get_current_line()
	local a = {}
	local l = 1
	for i = 1, #line do
		local char = string.sub(line, i, i)
		if char == c then
			a[l] = i
			l = l + 1
		end
	end
	local cursorCol = vim.api.nvim_win_get_cursor(0)[2]
	for i = 1, #a - 1, 2 do
		if cursorCol >= a[i] and cursorCol <= a[i + 1] then
			return 1
		end
	end
	return 0
end

function MoveToNextQuote(c, f, p)
	if c == "'" then
		if is_in_quote(c) then
			vim.cmd("normal! 2" .. f .. "'v" .. p .. "'")
		else
			vim.cmd("normal! 1" .. f .. "'v" .. p .. "'")
		end
	else
		if is_in_quote(c) then
			vim.cmd("normal! 2" .. f .. '"v' .. p .. '"')
		else
			vim.cmd("normal! 1" .. f .. '"v' .. p .. '"')
		end
	end
end
