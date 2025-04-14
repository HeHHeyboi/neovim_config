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
		-- NOTE: GDScript_lsp for godot

		lspconfig.gdscript.setup {
			capabilities = lsp_capabilities,
			root_dir = vim.fs.root(0, { 'project.godot', '.git' })
			-- NOTE: Can use Function Below
			-- root_dir = vim.fs.root(0, function(name, path)
			-- 	local root = { 'project.godot', '.git' }
			-- 	for i in ipairs(root) do
			-- 		if name == root[i] then
			-- 			return true
			-- 		end
			-- 	end
			-- 	return false
			-- end)
			-- Or This one for more Control
			-- root_dir = function()
			-- 	local parent = vim.fs.find({ 'project.godot', '.git' },
			-- 		{ upward = true, stop = "C:/Godot", limit = math.huge })
			-- 	if #parent == 0 then
			-- 		print("Godot project not found")
			-- 		return nil
			-- 	end
			-- 	return vim.fs.dirname(parent[1])
			-- end
		}
		lspconfig.ols.setup {
			capabilities = lsp_capabilities,
			init_options = {
				enable_snippets = true,
				enable_semantic_tokens = false,
				verbose = true,
				checker_args = "-vet-unused-variable -vet-shadowing"
			}
		}
		lspconfig.gopls.setup({
			capabilities = lsp_capabilities,
			settings = {
				gopls = {
					gofumpt = false,
					templateExtensions = { ".html", ".tmpl" },
					usePlaceholders = false,
					semanticTokens = true,
				}
			}
		})

		lspconfig.csharp_ls.setup({
			capabilities = lsp_capabilities,
		})
		lspconfig.jdtls.setup {}
		lspconfig.pylsp.setup({
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							ignore = { 'W391' },
							maxLineLength = 100
						}
					}
				}
			},
			capabilities = lsp_capabilities,
		})
		lspconfig.lua_ls.setup({
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
		vim.lsp.set_log_level("ERROR")
	end
}

return { M }
