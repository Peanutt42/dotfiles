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
		enable_cursor_hijack = true,
		hijack_netrw_behavior = "open_default",
		auto_clean_after_session_restore = true,
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
		default_component_configs = {
			indent = {
				padding = 0,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "╰╴",
				highlight = "NeoTreeIndentMarker",
			}
		},
		filesystem = {
			group_empty_dirs = true,
			scan_mode = "deep",
			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
		}
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)

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
