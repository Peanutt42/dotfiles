-- indentation guides
return {
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
}
