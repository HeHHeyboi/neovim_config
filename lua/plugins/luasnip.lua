return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	-- version = function()
	-- 	if vim.uv.os_uname == "Windows_NT" then
	-- 		return ""
	-- 	end
	-- 	return "v2.*"
	-- end
	-- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	-- build = "make install_jsregexp"
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		-- ls.filetype_extend("cs", { "unity" })
		ls.log.set_loglevel("error")
	end
}
