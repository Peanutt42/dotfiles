return {
	-- TODO: replace with "rmagatti/auto-session" once our PR with the git_use_branch_name fix has been merged
	"Peanutt42/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		git_use_branch_name = true,
		bypass_save_filetypes = { "neo-tree" },
		post_restore_cmds = {
			function()
				require("neo-tree.command").execute({
					action = "show",
					reveal = true
				})
			end
		},
	},
	config = function(_, opts)
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		require('auto-session').setup(opts)
	end
}
