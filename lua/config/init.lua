if vim.g.vscode then
	require('config.vscode-keymap')
else
	require('config.lazy')
	require('config.autocmd')
	require('config.neovide')
	require('config.keymap')
	require('config.colorscheme')
end
