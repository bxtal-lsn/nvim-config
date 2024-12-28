local setup = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" }, -- Use stylua for Lua files
			go = { "gofmt", "goimports" }, -- Use gofmt and goimports for Go files
		},
		format_on_save = {
			lsp_fallback = true, -- Use LSP formatter if no specific formatter is defined
		},
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("custom-autoformat", { clear = true }),
		callback = function(args)
			-- Autoformat files on save
			require("conform").format({
				bufnr = args.buf,
				lsp_fallback = true,
			})
		end,
	})
end

return { setup = setup }
