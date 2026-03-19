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
	config = function()
		require("neo-tree").setup(
		---@module 'neo-tree'
		---@type neotree.Config
			{
				enable_cursor_hijack = true,
				window = {
					position = "right",
					mappings = {
						["<C-b>"] = "close_window",
						["<leader>b"] = "close_window",
						["<esc>"] = "close_window",
						["<leftrelease>"] = "open",
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
				},
				default_component_configs = {
					indent = {
						padding = 0,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└", -- "│",
						highlight = "NeoTreeIndentMarker",
					}
				}
			}
		)

		vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#2F3337" })
	end,
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
