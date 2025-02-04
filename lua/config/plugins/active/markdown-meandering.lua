return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		code = {
			enabled = true,
			render_modes = false,
			sign = true,
			style = "full",
			position = "left",
			language_pad = 0,
			language_name = true,
			disable_background = { "diff" },
			width = "block", -- ✅ Change 'full' to 'block' to restrict background width
			left_margin = 0,
			left_pad = 1, -- ✅ Add slight padding for a better look
			right_pad = 1,
			min_width = 0,
			border = "thin",
			above = "▄",
			below = "▀",
			highlight = "RenderMarkdownCode",
			highlight_language = nil,
			inline_pad = 0,
			highlight_inline = "RenderMarkdownCodeInline",
		},
		heading = {
			enabled = true,
			render_modes = false,
			sign = true,
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			position = "overlay",
			signs = { "󰫎 " },
			width = "block", -- ✅ Change 'full' to 'block' for headings
			left_margin = 0,
			left_pad = 1,
			right_pad = 1,
			min_width = 0,
			border = false,
			border_virtual = false,
			border_prefix = false,
			above = "▄",
			below = "▀",
			backgrounds = {
				"RenderMarkdownH1Bg",
				"RenderMarkdownH2Bg",
				"RenderMarkdownH3Bg",
				"RenderMarkdownH4Bg",
				"RenderMarkdownH5Bg",
				"RenderMarkdownH6Bg",
			},
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
	},
}
