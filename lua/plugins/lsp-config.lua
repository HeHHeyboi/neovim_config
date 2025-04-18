-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "none" })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "none" })
local M =
{
	"neovim/nvim-lspconfig",
	cond = function()
		return not vim.opt.diff:get()
	end,
	config = function()
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
		print(lsp_capabilities.textDocument.completion.completionItem.snippetSupport)
		-- NOTE: GDScript_lsp for godot
		local enable_lsp = { 'gdscript', 'ols', 'lua_ls', 'gopls', 'csharp_ls', 'clangd', 'pylsp' }
		vim.lsp.config('*', {
			capabilities = lsp_capabilities,
		})

		vim.lsp.config('ols', {
			init_options = {
				enable_snippets = true,
				enable_semantic_tokens = false,
				verbose = true,
				checker_args = "-vet-unused-variable -vet-shadowing"
			},
		})
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					gofumpt = false,
					templateExtensions = { ".html", ".tmpl" },
					usePlaceholders = false,
					semanticTokens = true,
				}
			}
		})

		vim.lsp.config("csharp_ls", {})
		-- lspconfig.jdtls.setup {}
		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							ignore = { 'W391', 'W191' },
							maxLineLength = 100
						},
						yapf = {
							enabled = true
						},
						autopep8 = {
							enabled = false
						}
					}
				}
			},
		})
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
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
		})
		vim.lsp.config("clangd", {})
		vim.lsp.config("cmake", {})

		vim.lsp.set_log_level("ERROR")
		vim.lsp.enable(enable_lsp)
	end
}

return { M }
