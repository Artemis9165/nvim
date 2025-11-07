return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		config = function()
			local color = "github_dark_default"
			vim.cmd.colorscheme(color)
		end,
	},
}
