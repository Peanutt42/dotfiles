return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate"
	},
	"williamboman/mason-lspconfig.nvim",
	{
		"folke/trouble.nvim",
		opts = { use_diagnostic_signs = true },
	},
	"nvim-telescope/telescope.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = { window = { position = "right" } },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",		-- LSP source
			"hrsh7th/cmp-buffer",		-- buffer words
			"hrsh7th/cmp-path",			-- file paths
			"L3MON4D3/LuaSnip",			-- snippet engine (required)
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("config.ibl")
		end
	},
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			insert_at_start = false,
			auto_hide = 1,
			exclude_ft = { "neo-tree" },
		},
		version = '^1.0.0',
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { check_ts = true },
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require('crates')
			crates.setup(opts)
			crates.show()
		end,
	},
}
