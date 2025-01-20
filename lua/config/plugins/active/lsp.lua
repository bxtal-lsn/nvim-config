return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim",       opts = {} },
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure Lua language server
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Configure Golang language server
			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-.node_modules" },
						semanticTokens = true,
					},
				},
			})

			-- Set up autocmds for LSP actions
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					-- Format Lua files on save
					if vim.bo.filetype == "lua" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
							end,
						})
					end

					-- Format Go files on save
					if vim.bo.filetype == "go" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
								vim.lsp.buf.code_action({
									context = { only = { "source.organizeImports" } },
									apply = true,
								})
							end,
						})
					end
				end,
			})
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- golang
				"gopls",
				"gofumpt",
				"goimports",
				"goimports-reviser",
				"go-debug-adapter",
				"golangci-lint",
				"golangci-lint-langserver",
				"golines",
				"gotestsum",
				"gomodifytags",
				"gotests",
				-- end --
				"lua-language-server",
				"stylua", -- Used to format Lua code
				"terraform-ls",
				"hclfmt",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		end,
	},
}
