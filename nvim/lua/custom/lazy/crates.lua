-- display cargo crate versions
return {
	"saecki/crates.nvim",
	ft = { "rust", "toml" },
	event = { "BufRead Cargo.toml" },
	config = function(_, opts)
		local crates = require('crates')
		crates.setup(opts)
		crates.show()
	end,
}
