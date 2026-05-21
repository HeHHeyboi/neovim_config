vim.pack.add({
	'https://github.com/mfussenegger/nvim-jdtls',
	"https://github.com/seblyng/roslyn.nvim",
})

---@module 'roslyn.config'
---@type RoslynNvimConfig
require("roslyn").setup({
	broad_search = true
})
