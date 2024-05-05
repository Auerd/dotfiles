local function is_termux()
	if vim.env.TERMUX_VERSION ~= nil then
		return true
	end
	return false
end
return{
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		event = "VeryLazy",
		opts = {
			no_italic = is_termux(),
		},
	}
}
