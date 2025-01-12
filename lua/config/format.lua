local notify = vim.schedule_wrap(function(msg, level)
	vim.notify(msg, level)
end)

function Format_file(formatter, args)
	local name = vim.fn.bufname("%")
	local cmd = { vim.fn.exepath(formatter), args, name }
	if args == "" then
		cmd = { vim.fn.exepath(formatter), name }
	end
	vim.system(cmd, {}, function(out)
		if out.code ~= 0 then
			notify(out.stderr, vim.log.levels.ERROR)
			return
		end
		vim.defer_fn(function()
			vim.cmd("edit")
			notify("Format Success", vim.log.levels.INFO)
		end, 0)
	end)
end
