return {
	"nvim-mini/mini.move",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- Alt + h/j/k/l to move code selection
		mappings = {
			left = "<M-h>",
			right = "<M-l>",
			down = "<M-j>",
			up = "<M-k>",
		},
	}
}
