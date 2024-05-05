return{
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			light = "latte",
			dark = "mocha",
		},
		init = function()
			vim.cmd.colorscheme "catppuccin"
		end,
	}
}
