-- per line git status
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	---@module 'gitsigns'
	---@type Gitsigns.config
	opts = {
		attach_to_untracked = true,
	}
}
