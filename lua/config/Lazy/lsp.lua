local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"lopi-py/luau-lsp.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					luau = { "stylua" },
				},
				format_on_save = { lsp_fallback = true, async = false, timeout_ms = 500 },
			})
			require("fidget").setup({})
			require("mason").setup()

			require("luau-lsp").setup({
				sourcemap = {
					enabled = true,
					autogenerate = true,
					rojo_project_file = "default.project.json",
					sourcemap_file = "sourcemap.json",
				},
				plugin = {
					enabled = true,
					port = 3667,
				},
				fflags = {
					enable_new_solver = true,
					sync = true,
					override = {
						LuauTableTypeMaximumStringifierLength = "100",
					},
				},
				platform = {
					type = "roblox",
				},
				types = {
					roblox_security_level = "PluginSecurity",
				},

				require("mason-lspconfig").setup({
					automatic_enable = {
						exclude = { "luau_lsp" },
					},
					ensure_installed = { "lua_ls" },
					handlers = {
						function(server_name)
							require("lspconfig")[server_name].setup({ capabilities = capabilities })
						end,
						zls = function()
							local lspconfig = require("lspconfig")
							lspconfig.zls.setup({
								root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
								settings = {
									zls = {
										enable_inlay_hints = true,
										enable_snippets = true,
										warn_style = true,
									},
								},
							})
							vim.g.zig_fmt_parse_errors = 0
							vim.g.zig_fmt_autosave = 0
						end,

						["lua_ls"] = function()
							local lspconfig = require("lspconfig")
							lspconfig.lua_ls.setup({
								capabilities = capabilities,
								settings = {
									Lua = {
										format = {
											enable = true,
											defaultConfig = {
												indent_style = "tab",
												indent_size = "4",
											},
										},
									},
								},
							})
						end,
					},
				}),
			})

			vim.diagnostic.config({
				float = { focusable = false, style = "minimal", border = "rounded", source = true },
			})
		end,
	},
}
