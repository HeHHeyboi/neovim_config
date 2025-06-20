return {
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				gdscript = { "gdformat" },
				cs = { "csharpier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			format_after_save = {
				lsp_format = "fallback",
			},
			formatters = {
				csharpier = {
					inherit = false,
					command = "csharpier.cmd",
					args = { "format", "$FILENAME", "--write-stdout" },
				}
			}
		})
	end,
}
