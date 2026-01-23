return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = " [P]roject [G]rep" })
			vim.keymap.set("n", "<leader>ps", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>pw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>pr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>p.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>pe", function()
				-- try to find an already open diagnostic float
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)
					if vim.api.nvim_buf_get_option(buf, "buftype") == "nofile" and name:match(".*diagnostic.*") then
						vim.api.nvim_win_close(win, true)
						return
					end
				end

				-- otherwise open a new diagnostic float
				vim.diagnostic.open_float()
			end, { desc = "Toggle diagnostic float" })

			vim.keymap.set("n", "<leader>pF", function()
				builtin.find_files({
					hidden = true,
					no_ignore = true,
					no_ignore_parent = true,
				})
			end, { desc = "[P]roject [F]iles (include .gitignore)" })

			vim.keymap.set("n", "<leader>pG", function()
				builtin.live_grep({
					additional_args = function()
						return { "--no-ignore", "--hidden" }
					end,
				})
			end, { desc = "[P]roject [G]rep (include .gitignore)" })
			vim.keymap.set("n", "<leader>/", function()
				vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>p/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>pn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
