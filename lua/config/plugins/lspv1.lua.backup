return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
		},
		config = function()
			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				lua_ls,
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"gopls",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

			vim.keymap.set("", "<leader>l", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })
			require("config.autoformat").setup()
		end,
	},
}
-- return {
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		"stevearc/conform.nvim",
-- 		"williamboman/mason.nvim",
-- 		"williamboman/mason-lspconfig.nvim",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/nvim-cmp",
-- 		"L3MON4D3/LuaSnip",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"j-hui/fidget.nvim",
-- 	},
--
-- 	config = function()
-- 		require("conform").setup({
-- 			formatters_by_ft = {},
-- 		})
-- 		local cmp = require("cmp")
-- 		local cmp_lsp = require("cmp_nvim_lsp")
-- 		local capabilities = vim.tbl_deep_extend(
-- 			"force",
-- 			{},
-- 			vim.lsp.protocol.make_client_capabilities(),
-- 			cmp_lsp.default_capabilities()
-- 		)
--
-- 		require("fidget").setup({})
-- 		require("mason").setup()
-- 		require("mason-lspconfig").setup({
-- 			ensure_installed = {
-- 				"lua_ls",
-- 				"rust_analyzer",
-- 				"gopls",
-- 			},
-- 			handlers = {
-- 				function(server_name) -- default handler (optional)
-- 					require("lspconfig")[server_name].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end,
--
-- 				zls = function()
-- 					local lspconfig = require("lspconfig")
-- 					lspconfig.zls.setup({
-- 						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
-- 						settings = {
-- 							zls = {
-- 								enable_inlay_hints = true,
-- 								enable_snippets = true,
-- 								warn_style = true,
-- 							},
-- 						},
-- 					})
-- 					vim.g.zig_fmt_parse_errors = 0
-- 					vim.g.zig_fmt_autosave = 0
-- 				end,
-- 				["lua_ls"] = function()
-- 					local lspconfig = require("lspconfig")
-- 					lspconfig.lua_ls.setup({
-- 						capabilities = capabilities,
-- 						settings = {
-- 							Lua = {
-- 								runtime = { version = "Lua 5.1" },
-- 								diagnostics = {
-- 									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
-- 								},
-- 							},
-- 						},
-- 					})
-- 				end,
-- 			},
-- 		})
--
-- 		local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args)
-- 					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
-- 				end,
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" }, -- For luasnip users.
-- 			}, {
-- 				{ name = "buffer" },
-- 			}),
-- 		})
-- 		vim.diagnostic.config({
-- 			-- update_in_insert = true,
-- 			float = {
-- 				focusable = false,
-- 				style = "minimal",
-- 				border = "rounded",
-- 				source = "always",
-- 				header = "",
-- 				prefix = "",
-- 			},
-- 		})
-- 	end,
-- }
