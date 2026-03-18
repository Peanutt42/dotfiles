-- Filetree
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module 'neo-tree'
	---@type neotree.Config
	opts = {
		window = {
			position = "right",
			mappings = {
				["<C-b>"] = "close_window",
				["<leader>b"] = "close_window",
				["<esc>"] = "close_window",
			},
			mapping_options = {
				noremap = true,
				nowait = true,
			}
		},
		buffers = {
			follow_current_file = {
				enabled = true,
			},
		}
	},
	keys = {
		{
			"<C-b>",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
		},
		{
			"<leader>b",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
		},
	}
}
