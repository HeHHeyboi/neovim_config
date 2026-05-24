vim.api.nvim_create_user_command("Packlist", function(args)
	local plugins = vim.pack.get()
	local lines = {}
	table.insert(lines, string.format("# Total Plugin: %s", #plugins))
	table.insert(lines, "")
	for i, plugin in ipairs(plugins) do
		local name = plugin.spec.name or "(unknown)"
		local rev = plugin.rev or ""
		local src = plugin.spec.src or ""
		local path = plugin.path or ""
		table.insert(lines, string.format("%d. %s", i, name))
		table.insert(lines, string.format("  - src:  %s", src))
		table.insert(lines, string.format("  - rev:  %s", rev))
		table.insert(lines, string.format("  - path: %s", path))
		table.insert(lines, "")
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = "markdown"
	vim.cmd("tabnew")
	vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Get all plugin" })

local function get_plugin_name()
	local plugins = vim.pack.get()
	local names = {}
	for _, plugin in ipairs(plugins) do
		local name = plugin.spec.name
		table.insert(names, name)
	end
	return names
end

local function get_inactive_plugin()
	local plugins = vim.pack.get()
	local names = {}
	for _, plugin in ipairs(plugins) do
		if not plugin.active then
			local name = plugin.spec.name
			table.insert(names, name)
		end
	end
	return names
end

vim.api.nvim_create_user_command("Packupdate", function(args)
	if #args.fargs == 0 then
		vim.pack.update()
		return
	end

	local names = args.fargs
	vim.pack.update(names, { force = true })
end, { desc = "Update plugin", nargs = "*", complete = get_plugin_name })


vim.api.nvim_create_user_command("Packdel", function(args)
	if #args.fargs == 0 then
		print("Get Inactive Plugin...")
		local inactive_plugins = get_inactive_plugin()
		vim.pack.del(inactive_plugins)
		return
	else
		local del_plugins = args.fargs
		print("Delete Plugins" .. vim.inspect(del_plugins))
		local plugins = get_plugin_name()
		for _, del_plugin in ipairs(del_plugins) do
			local is_contain = vim.tbl_contains(plugins, del_plugin)
			if is_contain then
				vim.pack.del({ del_plugin }, { force = true })
			end
		end
	end
end, { desc = "Delete plugin", nargs = "*", complete = get_plugin_name })
