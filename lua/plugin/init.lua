require('plugin.lualine')
require('plugin.treesitter')
require('plugin.kanagawa')
require('plugin.nvim-cmp')

if not vim.opt.diff:get() then
	require('plugin.lsp-config')
	require('plugin.todo-comment')
	require('plugin.oil')
	require('plugin.telescope')
	require('plugin.comment')
	require('plugin.trouble')
end
-- require('plugin.nvim-dbee')
-- require('plugin.vim-dadbod')
-- require('plugin.noice')
-- require('plugin.conformFormat')
-- require('plugin.bufferline')
