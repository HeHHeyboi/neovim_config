local cb = function ()
	local cwd = vim.fs.normalize(vim.fn.getcwd())
	local config_dir = vim.fs.normalize(vim.fn.stdpath("config"))
	if cwd ~= config_dir then return end
	print("on")
	vim.pack.add({"https://github.com/folke/lazydev.nvim"})
	require("lazydev").setup({
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end

vim.api.nvim_create_autocmd('BufReadPost', {
	pattern = '*.lua',
	callback = cb,
})
