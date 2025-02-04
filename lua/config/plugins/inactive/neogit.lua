return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Neogit
			"sindrets/diffview.nvim", -- Optional but highly useful for reviewing diffs
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				disable_hint = false,             -- Show hints in the Neogit UI
				disable_context_highlighting = false, -- Enable contextual highlighting
				disable_signs = false,            -- Enable signs for better visibility
				disable_insert_on_commit = "auto", -- Start commit editor in normal mode unless the message is empty
				filewatcher = {
					interval = 500,                 -- Faster file refresh
					enabled = true,
				},
				graph_style = "unicode",      -- Improve graph readability in commits view
				use_default_keymaps = true,   -- Use default keybindings
				auto_refresh = true,          -- Refresh automatically
				remember_settings = true,     -- Persist settings across sessions
				use_per_project_settings = true, -- Store settings per repo
				sort_branches = "-committerdate", -- Sort branches by most recent commit

				-- Configure integrations
				integrations = {
					telescope = true, -- Use Telescope for selections
					diffview = true, -- Enable Diffview for side-by-side diffs
				},

				-- UI Preferences
				kind = "vsplit",                  -- Open Neogit in a vertical split
				disable_line_numbers = false,     -- Show line numbers
				disable_relative_line_numbers = true, -- Disable relative numbers
				console_timeout = 1000,           -- Show the console after 1s if a Git command is slow
				auto_show_console = true,         -- Automatically show console if command takes long
				auto_close_console = true,        -- Close console if Git command succeeds

				-- Keymaps for better navigation
				mappings = {
					status = {
						["<C-r>"] = "RefreshBuffer", -- Refresh the buffer quickly
						["<C-n>"] = "NextSection", -- Move to next section
						["<C-p>"] = "PreviousSection", -- Move to previous section
						["q"] = "Close",         -- Close Neogit
					},
				},
			})
		end,
	},
}
