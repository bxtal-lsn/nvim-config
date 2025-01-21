return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				sections = {
					{
						section = "terminal",
						cmd = "chafa ~/.config/tokyo-night.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
						height = 15,
						padding = 1,
					},
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},
}
