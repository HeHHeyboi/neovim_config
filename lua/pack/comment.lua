vim.pack.add({ "https://github.com/numToStr/Comment.nvim" })
local ft = require("Comment.ft")
ft.set("rust", { '//%s', '/*%s*/' })
ft.set('lox', { '//%s', '/*%s*/' })
require('Comment').setup({
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = "^$", ---LHS of toggle mappings in NORMAL mode
	toggler = {
		--Line-comment toggle keymap
		-- line = '<C-k>',
		line = 'gcc',
		-- -Block-comment toggle keymap
		block = 'gbc',
	},
	--LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		-- -Line-comment keymap
		-- line = '<C-/>',
		line = 'gc',
		---Block-comment keymap
		block = 'gb',
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = 'gcO',
		---Add comment on the line below
		below = 'gco',
		---Add comment at the end of line
		eol = 'gcA',
	},
	-- Enable keybindings
	-- NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		-- -Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = function(ctx)
		-- Comment.nvim's treesitter path crashes on Neovim 0.12 for
		-- filetypes without a parser (e.g. lox). Fall back to the ft ta
		local ok, parser = pcall(vim.treesitter.get_parser, 0)
		if ok and parser then return nil end
		return require('Comment.ft').get(vim.bo.filetype, ctx.ctype)
	end, ---Function to call after (un)comment
	post_hook = nil,
})
