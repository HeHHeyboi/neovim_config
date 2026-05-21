vim.pack.add({
	"https://github.com/stevearc/conform.nvim"
})
require("conform").setup({
	formatters_by_ft = {
		gdscript = { "gdformat" },
		cs = { "csharpier" },
		hurl = { "hurlfmt" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- format_on_save = function(bufnr)
	-- 	return {
	-- 		lsp_format = "fallback",
	-- 		timeout_ms = 1000,
	-- 	}
	-- end,
	format_after_save = function(bufnr)
		return {
			lsp_format = "fallback",
			timeout_ms = 1000,
		}
	end,
	formatters = {
		csharpier = {
			inherit = false,
			command = "csharpier.cmd",
			args = { "format", "$FILENAME", "--write-stdout" },
		}
	}
})
