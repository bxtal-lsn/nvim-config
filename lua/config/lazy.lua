local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit ..." },
			error("Error cloning lazy.nvim:\n" .. out),
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "config.plugins.autoformat" },
		{ import = "config.plugins.blink" },
		{ import = "config.plugins.dadbod" },
		{ import = "config.plugins.fugitive" },
		{ import = "config.plugins.gitsigns" },
		{ import = "config.plugins.lsp" },
		{ import = "config.plugins.oil" },
		{ import = "config.plugins.sleuth" },
		{ import = "config.plugins.telescope" },
		{ import = "config.plugins.todo" },
		{ import = "config.plugins.tokyonight" },
		{ import = "config.plugins.treesitter" },
		{ import = "config.plugins.trouble" },
		{ import = "config.plugins.xray_go" },
		{ import = "config.plugins.persistance" },
		{ import = "config.plugins.snacks" },
	},
})
