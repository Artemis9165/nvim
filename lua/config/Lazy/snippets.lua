return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.4.1",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
			})

			vim.filetype.add({
				extension = {
					luau = "luau",
				},
			})

			ls.add_snippets("luau", {
				ls.snippet("rbtemplate", {
					ls.text_node({
						"--!strict",
						"",
						"-- [Roblox Services]",
						"",
						"-- [Services]",
						"",
						"-- [Controllers]",
						"",
						"-- [Functions]",
						"",
						"-- [Remote Events]",
						"",
						"-- [Remote Functions]",
						"",
						"local private = {}",
						"local public = {}",
						"",
						"public.init = function() end",
						"",
						"return public",
					}),
				}),
			})

			vim.keymap.set({ "i" }, "<C-s>e", function()
				ls.expand()
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-s>;", function()
				ls.jump(1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-s>,", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
