return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		-- local harpoon_extensions = require("harpoon.extensions")
		-- harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
		-- REQUIRED
		harpoon:setup({
			default = {
				display = function(list_item)
					local norm = vim.fs.normalize(list_item.value)
					local cwd = vim.uv.cwd()
					if cwd == nil then
						return norm
					end

					local relative = vim.fs.relpath(cwd, norm)
					if relative == nil then
						return list_item.value
					end

					return relative
				end
			},
			settings = {
				save_on_toggle = false,
				sync_on_ui_close = true,
				key = function()
					local cwd = vim.uv.cwd()
					if cwd == nil then
						return ""
					end
					return cwd
				end
			},
		})
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<C-e>",
			function() harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded", height_in_lines = 5 }) end)

		-- vim.keymap.del("n", "<C-;>")
		-- vim.keymap.del("n", "<C-'>")

		vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "harpoon select 1" })
		vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "harpoon select 2" })
		vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "harpoon select 3" })
		vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end, { desc = "harpoon select 4" })
		vim.keymap.set("n", "<C-'>", function() harpoon:list():select(5) end, { desc = "harpoon select 5" })
		-- vim.keymap.set("n", "<leader>u", function() harpoon:list():select(1) end)
		-- vim.keymap.set("n", "<leader>i", function() harpoon:list():select(2) end)
		-- vim.keymap.set("n", "<leader>o", function() harpoon:list():select(3) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>n", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<leader>p", function() harpoon:list():next() end)
	end
}
