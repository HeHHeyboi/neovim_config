vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "none" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "none" })
local M =
{
	"neovim/nvim-lspconfig",
	cond = function()
		return not vim.opt.diff:get()
	end,
	config = function()
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- NOTE: GDScript_lsp for godot
		local gd_config = {
			capabilities = lsp_capabilities,
		}
		if vim.fn.has 'win64' == 1 then
			gd_config['cmd'] = { 'ncat', 'localhost', os.getenv 'GDScript_Port' or '6005' }
		end

		lspconfig.gdscript.setup {
			gd_config,
		}
		lspconfig.gopls.setup({
			capabilities = lsp_capabilities,
			settings = {
				gopls = {
					gofumpt = false,
					templateExtensions = { ".html", ".tmpl" },
					usePlaceholders = false,
				}
			}
		})

		lspconfig.csharp_ls.setup({
			capabilities = lsp_capabilities,
		})
		lspconfig.pylsp.setup({})
		lspconfig.jdtls.setup({
			-- cmd = { "jdtls", "-configuration", "~/.cache/jdtls/config", "-data", "~/.cache/jdtls/workspace" },
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
			capabilities = lsp_capabilities,
		})
		lspconfig.cmake.setup({
			capabilities = lsp_capabilities,
		})


		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").filetype_extend("cs", { "unity" })
		vim.lsp.set_log_level("OFF")
	end
}

return { M }
