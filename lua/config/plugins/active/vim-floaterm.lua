return {
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_width = 0.8 -- 80% of screen width
			vim.g.floaterm_height = 0.8 -- 80% of screen height
			vim.g.floaterm_wintype = "float" -- Floating window
			vim.g.floaterm_position = "center" -- Centered terminal
			vim.g.floaterm_borderchars = "─│─│┌┐┘└" -- Default border style
			vim.g.floaterm_autoinsert = true -- Automatically enter terminal mode
			vim.g.floaterm_autoclose = 1 -- Close terminal on successful command exit
		end,
	},
}
