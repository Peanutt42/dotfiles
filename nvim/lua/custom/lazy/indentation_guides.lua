-- indentation guides
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = { char = "▏" },
		scope = {
			enabled = true,
			include = {
				node_type = { ["*"] = { "*" } }
			},
		},
	}
}
