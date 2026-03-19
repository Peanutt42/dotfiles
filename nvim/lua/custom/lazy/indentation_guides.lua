-- indentation guides
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "▏" },
			scope = {
				enabled = true,
				include = {
					node_type = { ["*"] = { "*" } }
				}
			},
		}
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup({
				symbol = '▏',
				draw = {
					animation = require("mini.indentscope").gen_animation.linear({
						duration = 5
					})
				}
			})
		end,
	}
}
