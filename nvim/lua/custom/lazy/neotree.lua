-- sorts files more naturally:
-- for example file10.txt is AFTER file9.txt like we would expect
local function custom_natural_sort(a, b)
	local function normalize(s)
		s = tostring(s or "")
		return s:gsub("%d+", function(n)
			return string.format("%020d", tonumber(n))
		end):lower()
	end

	if a.type ~= b.type then
		return a.type == "directory"
	end

	return normalize(a.path) < normalize(b.path)
end

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
		sort_function = custom_natural_sort,
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
