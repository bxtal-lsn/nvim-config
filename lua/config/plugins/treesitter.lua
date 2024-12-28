return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"go",
					"gomod",
					"gosum",
					"gitignore",
					"dockerfile",
					"sql",
					"csv",
					"json",
					"yaml",
				},
				indent = { enable = true },
				sync_install = false, -- Install languages synchronously
				auto_install = true, -- Do not automatically install missing parsers
				ignore_install = {}, -- No parsers to ignore
				highlight = {
					enable = true,
					disable = function(_, buf) -- Removed unused 'lang'
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				textobjects = { select = { enable = true, lookahead = true } },
				modules = {}, -- Placeholder for custom modules (if needed)
			})
		end,
	},
}
