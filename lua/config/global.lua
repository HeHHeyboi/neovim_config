function Format_file(formatter, args)
	local name = vim.fn.bufname("%")
	local cmd = { vim.fn.exepath(formatter), args, name }
	vim.system(cmd, {}, function(out)
		if out.code ~= 0 then
			print(out.stderr)
		else
			-- Use vim.defer_fn to delay execution of these commands
			vim.defer_fn(function()
				vim.cmd("edit!")
				print("Format Success")
			end, 0)
		end
	end)
end
