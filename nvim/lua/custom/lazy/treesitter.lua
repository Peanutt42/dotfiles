return {
	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"vim", "vimdoc", "query", "regex", "latex", "yaml", "markdown",
				"markdown_inline",
				"bash", "fish", "diff",
				"c", "cpp", "lua", "luadoc", "rust", "vhdl", "haskell",
				"java", "nix", "just", "typst",
				"javascript", "typescript", "tsx", "html", "css",
			}

			require('nvim-treesitter').install(parsers)

			-- try to enable treesitter language for filetype and enable language specific indentation
			vim.api.nvim_create_autocmd('FileType', {
				callback = function(args)
					pcall(function()
						local language = vim.treesitter.language.get_lang(args.match)
						if not language then return end
						vim.treesitter.language.add(language)
						vim.treesitter.start(args.buf, language)
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end)
				end,
			})
		end,
	},
	-- "sticky" treesitter based context at the top
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			multiwindow = true,
			max_lines = 8,
		},
		config = function(_, opts)
			require("treesitter-context").setup(opts)
		end
	}
}
