local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
		if not ev.data.active then
			vim.cmd.packadd("telescope-fzf-native.nvim")
		end
		vim.system({ 'make' }, { cwd = ev.data.path }):wait()
	end

	if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
		if not ev.data.active then
			if kind == 'install' then
				vim.pack.add({ 'https://github.com/saghen/blink.lib' })
				vim.cmd.packadd("blink.lib")
			end
			vim.cmd.packadd("blink.cmp")
		end
		require('blink.cmp').build():pwait()
	end

	-- If action relies on code from the plugin (like user command or

	-- Lua code), make sure to explicitly load it first

	--  if name == 'plug-2' and kind == 'update' then
	--
	--    if not ev.data.active then
	--
	--      vim.cmd.packadd('plug-2')
	--
	--    end
	--
	--    vim.cmd('PlugTwoUpdate')
	--
	--    require('plug2').after_update()
	--
	--  end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })
