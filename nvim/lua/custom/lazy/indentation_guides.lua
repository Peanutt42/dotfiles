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
			-- disable inside neo-tree
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "neo-tree",
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	}
}
