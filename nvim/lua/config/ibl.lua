require("ibl").setup({
	indent = { char = "▏" },
	scope = {
		enabled = true,
		include = {
			node_type = { ["*"] = { "*" } }
		}
	},
})
