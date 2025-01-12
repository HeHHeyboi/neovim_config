if vim.g.vscode then
	require('config.vscode-keymap')
else
	require('config.lazy')
	require('config.keymap')
	require('config.autocmd')
	require('config.neovide')
end
