-- Fuzzy file(/or anything) finder
return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{
			"<leader>ff",
			function() require("telescope.builtin").find_files() end,
			mode = "n",
			desc = "Find files",
		},
		{
			"<C-p>",
			function() require("telescope.builtin").find_files() end,
			mode = "n",
			desc = "Find files",
		},
		{
			"<leader>fg",
			function() require("telescope.builtin").git_files() end,
			mode = "n",
			desc = "Git files",
		},
		{
			"<leader>fs",
			function() require("telescope.builtin").live_grep() end,
			mode = "n",
			desc = "Live grep",
		},
		{
			"<leader>fb",
			function() require("telescope.builtin").buffers() end,
			mode = "n",
			desc = "Buffers",
		},
		{
			"<leader>fh",
			function() require("telescope.builtin").help_tags() end,
			mode = "n",
			desc = "Help tags",
		},
	},
	opts = {}
}
