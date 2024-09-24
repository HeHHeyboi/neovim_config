vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "jdtls", "cmake", "clangd" },
})
require("neodev").setup({})
--require("java").setup({})


local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local gd_config = {
	capabilities = lsp_capabilities,
	setting = {},
}
if vim.fn.has 'win64' == 1 then
	gd_config['cmd'] = { 'ncat', 'localhost', os.getenv 'GDScript_Port' or '6005' }
end
lspconfig.gdscript.setup { gd_config }
lspconfig.gradle_ls.setup {
	capabilities = lsp_capabilities,
}
lspconfig.powershell_es.setup({
	capabilities = lsp_capabilities,
})
lspconfig.csharp_ls.setup({
	capabilities = lsp_capabilities,
})
lspconfig.pylsp.setup({

})
lspconfig.jdtls.setup({
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "C:/JavaTool/jdk-21.0.2",
						default = true,
					}
				}
			}
		}
	},
	capabilities = lsp_capabilities,
})
lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			},
			format = {
				-- Enable code formatting
				enable = true,
			},
			diagnostics = {
				-- Get the server to recognize the vim global
				globals = { "vim" }
			},
		}
	},
	capabilities = lsp_capabilities,
})
lspconfig.clangd.setup({
	--on_attach = function(client, bufnr)
	--client.server_capabilities.signatureHelpProvider = false
	--on_attach(client, bufnr)
	--end,
	capabilities = lsp_capabilities,
})
lspconfig.cmake.setup({
	capabilities = lsp_capabilities,
})
local on_attach = function(client, bufnr)
	local _notify = client.notify

	client.notify = function(method, params)
		if method == 'textDocument/didClose' then
			-- Godot doesn't implement didClose yet
			return
		end
		_notify(method, params)
	end
end
require 'lspconfig'.gdscript.setup {
	on_attach = on_attach,
	filetypes = { "gd", "gdscript", "gdscript3" },
}


require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("cs", { "unity" })
vim.lsp.set_log_level("debug")
