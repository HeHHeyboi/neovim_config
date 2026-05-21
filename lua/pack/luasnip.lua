vim.pack.add({
	github("L3MON4D3/LuaSnip"),
	github("rafamadriz/friendly-snippets"),
})

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
-- ls.filetype_extend("cs", { "unity" })
ls.log.set_loglevel("error")
