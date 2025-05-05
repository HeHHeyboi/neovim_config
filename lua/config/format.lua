local notify = vim.schedule_wrap(function(msg, level)
	vim.notify(msg, level)
end)
Custom_format = {
	hurl = {
		cmd = "hurlfmt",
		arg = "--in-place"
	},
	gdscript = {
		cmd = "gdformat",
		arg = ""
	},
}

function Format_file(formatter, args)
	local name = vim.fn.bufname("%")
	local exe = vim.fn.exepath(formatter)
	if exe == "" then
		notify("Formatter not found: " .. formatter, vim.log.levels.ERROR)
		return
	end

	local cmd = { exe }
	if args ~= "" then
		table.insert(cmd, args)
	end
	table.insert(cmd, name)
	local job = vim.system(cmd, {})
	local result = job:wait()
	if result.code ~= 0 then
		notify(result.stderr, vim.log.levels.ERROR)
		return
	end
	vim.cmd("edit")
	notify("format " .. name .. " success", vim.log.levels.INFO)
end

-- local job = vim.fn.jobstart(cmd, {
-- 	on_stdout = function()
-- 		vim.cmd("edit")
-- 		notify("Format " .. name .. " Success", vim.log.levels.INFO)
-- 	end
-- })
-- vim.fn.jobwait({ job })

-- vim.system(cmd, {}, function(out)
-- 	if out.code ~= 0 then
-- 		notify(out.stderr, vim.log.levels.error)
-- 		return
-- 	end
-- 	vim.defer_fn(function()
-- 		vim.cmd("edit")
-- 		notify("format " .. name .. " success", vim.log.levels.info)
-- 	end, 0)
-- end)
