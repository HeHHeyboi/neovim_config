if vim.g.vscode then
	-- VSCode extension
else
	require('plugin.bufferline')
	require('plugin.conformFormat')
	require('plugin.lsp-config')
	require('plugin.lualine')
	require('plugin.nvim-cmp')
	require('plugin.oil')
	require('plugin.telescope')
	require('plugin.treesitter')
	require('plugin.trouble')
	require('plugin.comment')
	-- ordinary Neovim
end
