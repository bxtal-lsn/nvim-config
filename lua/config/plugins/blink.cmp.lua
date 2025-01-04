return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "*",
		build = "nix run .#build-plugin",

		opts = {
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "normal",
			},
			signature = { enabled = true },
		},
	},
}
