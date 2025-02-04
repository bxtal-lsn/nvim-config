return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = { prompt_position = "top" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
				pickers = {
					find_files = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
				},
			})

			telescope.load_extension("fzf")

			-- Keymaps
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

			vim.keymap.set("n", "<leader>en", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Edit Neovim config files" })

			vim.keymap.set("n", "<leader>ep", function()
				builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
			end, { desc = "Edit plugin files" })

			vim.keymap.set(
				"n",
				"<leader>fx",
				builtin.treesitter,
				{ desc = "Treesitter symbols", noremap = true, silent = true }
			)

			vim.keymap.set(
				"n",
				"<leader>ff",
				builtin.find_files,
				{ desc = "Find files", noremap = true, silent = true }
			) -- Lists files in your current working directory, respects .gitignore
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>fs",
			-- 	builtin.spell_suggest,
			-- 	{ desc = "Spell suggestions", noremap = true, silent = true }
			-- ) -- Lists spell options
			--
			-- Load additional custom config (if any)
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>fc",
			-- 	builtin.current_buffer_fuzzy_find,
			-- 	{ desc = "Search in current file", noremap = true, silent = true }
			-- )
			--require("config.telescope.multigrep").setup()
		end,
	},
}
